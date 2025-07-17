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
    struct State {
        // MARK: - Navigation
        var path = StackState<Path.State>()
        
        // MARK: - Data
        var quizSteps: [QuizStep] = []
        
        // MARK: - UI State
        var isLoading: Bool = false
        var alert: AlertState<Action.Alert>?
    }
    
    // MARK: - Actions
    enum Action {
        case takeQuizTapped
        case path(StackAction<Path.State, Path.Action>)
        case quizLoaded(TaskResult<[QuizStep]>)
        case alert(PresentationAction<Alert>)
        
        enum Alert {}
    }
    
    // MARK: - Dependencies
    @Dependency(\.quizService) var quizService
    
    // MARK: - Reducer
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
                state.alert = AlertState {
                    TextState("Oops")
                } actions: {
                    ButtonState(role: .cancel) {
                        TextState("OK")
                    }
                } message: {
                    TextState("Something went wrong while loading the quiz.")
                }
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
                
            case .alert(_):
                return .none
            }
        }
        .forEach(\.path, action: \.path)
        .ifLet(\.alert, action: \.alert)
    }
}

// MARK: - Navigation Path
extension IntroFeature {
    @Reducer(state: .equatable)
    enum Path {
        case quiz(QuizFeature)
    }
}
