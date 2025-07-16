//
//  QuizFeature.swift
//  TestTitle
//
//  Created by Yuliia Marych on 16.07.2025.
//

import ComposableArchitecture

@Reducer
struct QuizFeature {
    
    @ObservableState
    struct State: Equatable {}
    
    enum Action: Equatable {}
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            default: return .none
            }
        }
    }
}
