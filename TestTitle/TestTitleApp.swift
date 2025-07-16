//
//  TestTitleApp.swift
//  TestTitle
//
//  Created by Yuliia Marych on 15.07.2025.
//

import SwiftUI
import ComposableArchitecture

@main
struct TestTitleApp: App {
    var body: some Scene {
        WindowGroup {
            IntroView(store: Store(initialState: IntroFeature.State(), reducer: { IntroFeature() }))
        }
    }
}
