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
        @Presents var quiz: QuizFeature.State?
    }
    
    enum Action: Equatable {
        case takeQuizTapped
        case quiz(PresentationAction<QuizFeature.Action>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .takeQuizTapped:
                state.quiz = QuizFeature.State()
                return .none
                
            case .quiz:
                return .none
            }
        }
        .ifLet(\.$quiz, action: \.quiz) {
            QuizFeature()
        }
    }
}
