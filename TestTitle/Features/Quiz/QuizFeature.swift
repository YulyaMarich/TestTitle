//
//  QuizFeature.swift
//  TestTitle
//
//  Created by Yuliia Marych on 16.07.2025.
//

import ComposableArchitecture
import SwiftUI

enum QuizViewStep: Equatable, Identifiable {
    case stylistFocus
    case style
    case colors
    
    var id: Self { self }
}

struct QuizStepMetadata: Equatable {
    let title: String
    let subtitle: String?
}

@Reducer
struct QuizFeature {
    @ObservableState
    struct State: Equatable {
        var quizSteps: [QuizStep]
        var currentStepIndex: Int = 0
        
        var steps: [QuizViewStep] {
            quizSteps.map { $0.viewStep }
        }
        
        var step: QuizViewStep {
            steps[currentStepIndex]
        }
        
        var isStepValid: Bool {
            switch step {
            case .stylistFocus:
                return !selectedStylistFocusIDs.isEmpty
            case .style:
                return selectedStyleID != nil
            case .colors:
                return !selectedColorIDs.isEmpty
            }
        }
        
        var isLastStep: Bool {
            currentStepIndex == steps.count - 1
        }
        
        var isFirstStep: Bool {
            currentStepIndex == 0
        }
        
        var selectedStylistFocusIDs: Set<String> = []
        var stylistFocusOptions: [StylistFocusOption] = []
        
        var selectedStyleID: String?
        var styleOptions: [StyleOption] = []
        
        var selectedColorIDs: Set<String> = []
        var colorOptions: [ColorOption] = []
        
        var stepMetadata: [QuizViewStep: QuizStepMetadata] = [:]
        
        init(quizSteps: [QuizStep], currentStepIndex: Int = 0) {
            self.quizSteps = quizSteps
            self.currentStepIndex = currentStepIndex
            self.stepMetadata = Dictionary(uniqueKeysWithValues: quizSteps.map {
                ($0.viewStep, QuizStepMetadata(title: $0.title, subtitle: $0.subtitle))
            })
            
            if let step = quizSteps[safe: currentStepIndex] {
                switch step.viewStep {
                case .stylistFocus:
                    self.stylistFocusOptions = step.stylistFocusOptions ?? []
                case .style:
                    self.styleOptions = step.styleOptions ?? []
                case .colors:
                    self.colorOptions = step.colorOptions ?? []
                }
            }
        }
        
        var currentStepModel: QuizStep? {
            quizSteps[safe: currentStepIndex]
        }
    }
    
    enum Action: Equatable {
        case nextTapped
        case finishTapped
        case backTapped
        case goToNextStep([QuizViewStep], Int)
        case stylistFocusOptionTapped(String)
        case styleOptionTapped(String)
        case colorOptionTapped(String)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .nextTapped:
                return .send(.goToNextStep(state.steps, state.currentStepIndex))
                
            case let .stylistFocusOptionTapped(id):
                if state.selectedStylistFocusIDs.contains(id) {
                    state.selectedStylistFocusIDs.remove(id)
                } else {
                    state.selectedStylistFocusIDs.insert(id)
                }
                return .none
                
            case let .styleOptionTapped(id):
                state.selectedStyleID = id
                return .none
                
            case let .colorOptionTapped(id):
                if state.selectedColorIDs.contains(id) {
                    state.selectedColorIDs.remove(id)
                } else {
                    state.selectedColorIDs.insert(id)
                }
                return .none
                
            case .backTapped, .goToNextStep, .finishTapped:
                return .none
            }
        }
    }
}
