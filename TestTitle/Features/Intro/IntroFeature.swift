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
    }
    
    enum Action {
        case takeQuizTapped
        case path(StackAction<Path.State, Path.Action>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .takeQuizTapped:
                state.path.append(.quiz(.init(step: .stylistFocus)))
                return .none
                
            case .path(.element(id: _, action: .quiz(.nextTapped))):
                if let current = state.path.last?.quiz?.step,
                   let next = current.next {
                    state.path.append(.quiz(.init(step: next)))
                }
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
    public enum Path {
        case quiz(QuizFeature)
    }
}
