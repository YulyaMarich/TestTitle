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
            VStack(spacing: 20) {
                Text(store.step.navigationTitle)
                    .font(.largeTitle)
                    .padding()
            }
        }
    }
}
