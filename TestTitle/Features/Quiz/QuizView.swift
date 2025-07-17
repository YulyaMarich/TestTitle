//
//  QuizView.swift
//  TestTitle
//
//  Created by Yuliia Marych on 16.07.2025.
//

import SwiftUI
import ComposableArchitecture

struct QuizView: View {
    @ComposableArchitecture.Bindable var store: StoreOf<QuizFeature>
    
    var body: some View {
        WithPerceptionTracking {
            VStack(spacing: 0) {
                ScrollView {
                    VStack {
                        header
                            .padding(.bottom, 24)
                        Spacer()
                        content
                        Spacer()
                        
                    }
                    .padding(.bottom, 10)
                    .padding(.horizontal, 20)
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
                .frame(height: 48)
                .padding(.horizontal, 20)
                .padding(.bottom, 22)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("STYLE PREFERENCES")
                        .font(.poppins(size: 15, weight: .medium))
                        .foregroundColor(.black)
                }
                
                if !store.isFirstStep {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            store.send(.backTapped)
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.black)
                        }
                    }
                }
            }
        }
    }
    
    private var header: some View {
        let metadata = store.stepMetadata[store.step]
        return VStack(alignment: .leading, spacing: 8) {
            if let title = metadata?.title {
                Text(title)
                    .font(.kaiseiTokumin(size: 26))
            }
            if let subtitle = metadata?.subtitle {
                Text(subtitle)
                    .font(.poppins(size: 14, weight: .light))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var content: some View {
        Group {
            switch store.state.step {
            case .stylistFocus:
                StylistFocusListView(
                    options: store.stylistFocusOptions,
                    selectedIDs: store.selectedStylistFocusIDs,
                    onTap: { id in
                        store.send(.stylistFocusOptionTapped(id))
                    }
                )
            case .style:
                StyleGridView(
                    options: store.styleOptions,
                    selectedID: store.selectedStyleID,
                    onTap: { id in
                        store.send(.styleOptionTapped(id))
                    }
                )
            case .colors:
                ColorGridView(
                    options: store.colorOptions,
                    selectedIDs: store.selectedColorIDs,
                    onTap: { id in
                        store.send(.colorOptionTapped(id))
                    }
                )
            }
        }
    }
}
