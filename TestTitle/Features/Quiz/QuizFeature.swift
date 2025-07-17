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
        
        var currentStepModel: QuizStep? {
            quizSteps[safe: currentStepIndex]
        }
        
        var selectionMode: SelectionMode {
            guard let mode = currentStepModel?.selectionMode else {
                return .single
            }
            return mode
        }
        
        var isStepValid: Bool {
            !selectedOptionIDs.isEmpty
        }
        
        var isLastStep: Bool {
            currentStepIndex == steps.count - 1
        }
        
        var isFirstStep: Bool {
            currentStepIndex == 0
        }
        
        var selectedOptionIDs: Set<String> = []
        var currentOptions: [QuizOption] = []
        
        var stepMetadata: [QuizViewStep: QuizStepMetadata] = [:]
        
        init(quizSteps: [QuizStep], currentStepIndex: Int = 0) {
            self.quizSteps = quizSteps
            self.currentStepIndex = currentStepIndex
            self.stepMetadata = Dictionary(uniqueKeysWithValues: quizSteps.map {
                ($0.viewStep, QuizStepMetadata(title: $0.title, subtitle: $0.subtitle))
            })
            
            if let step = quizSteps[safe: currentStepIndex] {
                self.currentOptions = step.options
            }
        }
    }
    
    enum Action: Equatable {
        case nextTapped
        case finishTapped
        case backTapped
        case goToNextStep([QuizViewStep], Int)
        case optionTapped(String)
    }
    
    @Dependency(\.quizAnswerStorage) var quizAnswerStorage
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .finishTapped:
                saveAnswer(state: &state)
                return .none
                
            case .nextTapped:
                saveAnswer(state: &state)
                return .send(.goToNextStep(state.steps, state.currentStepIndex))
                
            case .goToNextStep:
                return .none
                
            case .backTapped:
                state.currentStepIndex -= 1
                if let step = state.quizSteps[safe: state.currentStepIndex] {
                    state.currentOptions = step.options
                    state.selectedOptionIDs = []
                }
                return .none
                
            case let .optionTapped(id):
                switch state.selectionMode {
                case .single:
                    state.selectedOptionIDs = [id]
                case .multiple:
                    if state.selectedOptionIDs.contains(id) {
                        state.selectedOptionIDs.remove(id)
                    } else {
                        state.selectedOptionIDs.insert(id)
                    }
                }
                return .none
            }
        }
    }
    
    private func saveAnswer(state: inout State) {
        guard let step = state.currentStepModel else { return }
        
        let answer = QuizAnswer(
            questionID: step.id,
            selectedOptionIDs: state.selectedOptionIDs.compactMap { Int($0) }
        )
        
        do {
            try quizAnswerStorage.save(answer)
        } catch {
            print("❌ Save error: \(error)")
        }
    }
}
