//
//  IntroView.swift
//  TestTitle
//
//  Created by Yuliia Marych on 15.07.2025.
//

import SwiftUI
import ComposableArchitecture

struct IntroUIConfiguration {
    static let horizontalPadding: CGFloat = 20
    static let bottomButtonPadding: CGFloat = 28
    static let textButtonVerticaSpacing: CGFloat = 61
    static let buttonHeight: CGFloat = 42
    
    static let gradientStops: [Gradient.Stop] = [
        .init(color: Color.black.opacity(0), location: 0.2992),
        .init(color: Color.black, location: 0.8092)
    ]
    
    static let titleFontSize: CGFloat = 32
}

struct IntroView: View {
    @Perception.Bindable var store: StoreOf<IntroFeature>
    
    var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
                VStack(spacing: 0) {
                    Spacer()
                    
                    VStack(spacing: IntroUIConfiguration.textButtonVerticaSpacing) {
                        Text("Online Personal \nStyling. \nOutfits for \nEvery Woman.")
                            .multilineTextAlignment(.leading)
                            .font(.kaiseiTokumin(size: IntroUIConfiguration.titleFontSize))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.white)
                        
                        PrimaryButton(
                            title: "Take a quiz",
                            buttonType: .light,
                            isEnabled: !store.isLoading,
                            isLoading: store.isLoading,
                            action: {
                                store.send(.takeQuizTapped)
                            }
                        )
                        .frame(height: IntroUIConfiguration.buttonHeight)
                    }
                    .padding(.bottom, IntroUIConfiguration.bottomButtonPadding)
                }
                .padding(.horizontal, IntroUIConfiguration.horizontalPadding)
                .navigationBarHidden(true)
                .background {
                    Image("introBackground")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .overlay(backgroundGradient)
                }
            } destination: { store in
                WithPerceptionTracking {
                    switch store.case {
                    case .quiz:
                        if let store = store.scope(state: \.quiz, action: \.quiz) {
                            QuizView(store: store)
                        }
                    }
                }
            }
            .alert($store.scope(state: \.alert, action: \.alert))
        }
    }
    
    private var backgroundGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(stops: IntroUIConfiguration.gradientStops),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

#Preview {
    IntroView(store: Store(initialState: IntroFeature.State(), reducer: { IntroFeature() }))
}
