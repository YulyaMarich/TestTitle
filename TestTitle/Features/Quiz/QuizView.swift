//
//  QuizView.swift
//  TestTitle
//
//  Created by Yuliia Marych on 16.07.2025.
//

import SwiftUI
import ComposableArchitecture

struct QuizView: View {
    var store: StoreOf<QuizFeature>
    
    var body: some View {
        Text("Quiz Screen")
            .font(.largeTitle)
            .padding()
    }
}
