//
//  AppDelegate.swift
//  TestTitle
//
//  Created by Yuliia Marych on 17.07.2025.
//

import Foundation
import Firebase
import FirebaseRemoteConfig

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}
