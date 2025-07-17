//
//  QuizView.swift
//  TestTitle
//
//  Created by Yuliia Marych on 16.07.2025.
//

import SwiftUI
import ComposableArchitecture

struct QuizUIConfiguration {
    static let horizontalPadding: CGFloat = 20
    static let bottomPadding: CGFloat = 10
    static let headerBottomPadding: CGFloat = 24
    static let buttonHeight: CGFloat = 48
    static let buttonBottomPadding: CGFloat = 22
    static let toolbarFontSize: CGFloat = 15
    static let chevronSize: CGFloat = 24
    static let titleFontSize: CGFloat = 26
    static let subtitleFontSize: CGFloat = 14
    static let headerSpacing: CGFloat = 8
}

struct QuizView: View {
    @Perception.Bindable var store: StoreOf<QuizFeature>
    
    var body: some View {
        WithPerceptionTracking {
            VStack(spacing: 0) {
                ScrollView {
                    VStack {
                        header
                            .padding(.bottom, QuizUIConfiguration.headerBottomPadding)
                        Spacer()
                        content
                        Spacer()
                    }
                    .padding(.bottom, QuizUIConfiguration.bottomPadding)
                    .padding(.horizontal, QuizUIConfiguration.horizontalPadding)
                }
                .scrollIndicators(.hidden)
                
                PrimaryButton(
                    title: store.isLastStep ? "Finish" : "Continue",
                    buttonType: .dark,
                    isEnabled: store.isStepValid
                ) {
                    store.send(
                        store.isLastStep
                        ? .finishTapped
                        : .nextTapped
                    )
                }
                .frame(height: QuizUIConfiguration.buttonHeight)
                .padding(.horizontal, QuizUIConfiguration.horizontalPadding)
                .padding(.bottom, QuizUIConfiguration.buttonBottomPadding)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("STYLE PREFERENCES")
                        .font(.poppins(size: QuizUIConfiguration.toolbarFontSize, weight: .medium))
                        .foregroundColor(.black)
                }
                
                if !store.isFirstStep {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            store.send(.backTapped)
                        }) {
                            Image("chevronLeft")
                                .resizable()
                                .scaledToFit()
                                .frame(width: QuizUIConfiguration.chevronSize, height: QuizUIConfiguration.chevronSize)
                                .foregroundColor(.surfaceAccent)
                        }
                    }
                }
            }
        }
    }
    
    private var header: some View {
        let metadata = store.stepMetadata[store.step]
        return VStack(alignment: .leading, spacing: QuizUIConfiguration.headerSpacing) {
            if let title = metadata?.title {
                Text(title)
                    .font(.kaiseiTokumin(size: QuizUIConfiguration.titleFontSize))
            }
            if let subtitle = metadata?.subtitle {
                Text(subtitle)
                    .font(.poppins(size: QuizUIConfiguration.subtitleFontSize, weight: .light))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var content: some View {
        Group {
            switch store.state.step {
            case .stylistFocus:
                StylistFocusListView(
                    options: store.currentOptions.compactMap { $0.toStylistFocusOption() },
                    selectedIDs: store.selectedOptionIDs,
                    onTap: { id in store.send(.optionTapped(id)) }
                )
            case .style:
                StyleGridView(
                    options: store.currentOptions.compactMap { $0.toStyleOption() },
                    selectedIDs: store.selectedOptionIDs,
                    onTap: { id in store.send(.optionTapped(id)) }
                )
            case .colors:
                ColorGridView(
                    options: store.currentOptions.compactMap { $0.toColorOption() },
                    selectedIDs: store.selectedOptionIDs,
                    onTap: { id in store.send(.optionTapped(id)) }
                )
            }
        }
    }
}
