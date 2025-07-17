//
//  IntroFeature.swift
//  TestTitle
//
//  Created by Yuliia Marych on 16.07.2025.
//

import Foundation
import ComposableArchitecture

@Reducer
struct IntroFeature {
    @ObservableState
    struct State: Equatable {
        var path = StackState<Path.State>()
        var quizSteps: [QuizStep] = []
        var isLoading: Bool = false
    }
    
    enum Action {
        case takeQuizTapped
        case path(StackAction<Path.State, Path.Action>)
        case quizLoaded(TaskResult<[QuizStep]>)
    }
    
    @Dependency(\.quizService) var quizService
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .takeQuizTapped:
                if state.quizSteps.isEmpty {
                    state.isLoading = true
                    return .run { send in
                        await send(.quizLoaded(
                            TaskResult { try await quizService.fetchQuiz() }
                        ))
                    }
                } else {
                    state.path.append(.quiz(.init(quizSteps: state.quizSteps)))
                    return .none
                }
                
            case let .quizLoaded(.success(steps)):
                guard !steps.isEmpty else {
                    print("⚠️ Quiz steps is empty.")
                    return .none
                }
                state.isLoading = false
                state.quizSteps = steps
                state.path.append(.quiz(.init(quizSteps: steps)))
                return .none
            case let .quizLoaded(.failure(error)):
                state.isLoading = false
                print("❌ Failed to load quiz: \(error)")
                return .none
                
            case let .path(.element(id: _, action: .quiz(.goToNextStep(steps, currentIndex)))):
                if currentIndex + 1 < steps.count {
                    state.path.append(
                        .quiz(.init(
                            quizSteps: state.quizSteps,
                            currentStepIndex: currentIndex + 1
                        ))
                    )
                }
                return .none
                
            case .path(.element(id: _, action: .quiz(.backTapped))):
                state.path.removeLast()
                return .none
                
            case .path(.element(id: _, action: .quiz(.finishTapped))):
                state.path.removeAll()
                return .none
                
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}

extension IntroFeature {
    @Reducer(state: .equatable)
    enum Path {
        case quiz(QuizFeature)
    }
}
