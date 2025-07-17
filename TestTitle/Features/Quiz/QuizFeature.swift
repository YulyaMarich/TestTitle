//
//  QuizFeature.swift
//  TestTitle
//
//  Created by Yuliia Marych on 16.07.2025.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct QuizFeature {
    @ObservableState
    struct State: Equatable {
        // MARK: - Core Data
        var quizSteps: [QuizStep]
        var currentStepIndex: Int = 0

        // MARK: - UI State
        var selectedOptionIDs: Set<String> = []
        var currentOptions: [QuizOption] = []

        // MARK: - Metadata
        var stepMetadata: [QuizViewStep: QuizStepMetadata] = [:]

        init(quizSteps: [QuizStep], currentStepIndex: Int = 0) {
            self.quizSteps = quizSteps
            self.currentStepIndex = currentStepIndex
            self.stepMetadata = quizSteps.reduce(into: [:]) { dict, step in
                let key = step.viewStep
                if dict[key] == nil {
                    dict[key] = QuizStepMetadata(title: step.title, subtitle: step.subtitle)
                }
            }
            if let step = quizSteps[safe: currentStepIndex] {
                self.currentOptions = step.options
            }
        }
    }

    // MARK: - Actions
    enum Action: Equatable {
        case nextTapped
        case finishTapped
        case backTapped
        case goToNextStep([QuizViewStep], Int)
        case optionTapped(String)
    }

    // MARK: - Dependencies
    @Dependency(\.quizAnswerStorage) var quizAnswerStorage

    // MARK: - Reducer
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
}

// MARK: - State Computed Properties
extension QuizFeature.State {
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
}

// MARK: - Private Helpers
private extension QuizFeature {
    func saveAnswer(state: inout State) {
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
