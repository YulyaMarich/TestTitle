//
//  QuizFeature.swift
//  TestTitle
//
//  Created by Yuliia Marych on 16.07.2025.
//

import ComposableArchitecture

enum QuizViewStep: Equatable, Identifiable {
    case stylistFocus
    case style
    case colors
    
    var id: Self { self }
    
    var navigationTitle: String {
        switch self {
        case .stylistFocus: return "Lifestyle & Interests"
        case .style: return "Style preferences"
        case .colors: return "Color preferences"
        }
    }
    
    var next: QuizViewStep? {
        switch self {
        case .stylistFocus: return .style
        case .style: return .colors
        case .colors: return nil
        }
    }
}

@Reducer
struct QuizFeature {
    @ObservableState
    struct State: Equatable {
        var step: QuizViewStep
    }
    
    enum Action: Equatable {
        case nextTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { _, action in
            switch action {
            case .nextTapped:
                return .none
            }
        }
    }
}
