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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            IntroView(store: Store(initialState: IntroFeature.State(), reducer: { IntroFeature() }))
        }
    }
}
