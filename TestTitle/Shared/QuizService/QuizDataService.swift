//
//  QuizDataService.swift
//  TestTitle
//
//  Created by Yuliia Marych on 17.07.2025.
//

import Foundation
import FirebaseRemoteConfig

protocol QuizService {
    func fetchQuiz() async throws -> [QuizStep]
}

final class QuizServiceImpl: QuizService {
    private let remoteConfig: RemoteConfig
    
    init(remoteConfig: RemoteConfig = .remoteConfig()) {
        self.remoteConfig = remoteConfig
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
    }
    
    func fetchQuiz() async throws -> [QuizStep] {
        try await remoteConfig.fetchAndActivate()
        
        let jsonString = remoteConfig["quiz_json"].stringValue
        
        guard let data = jsonString.data(using: .utf8) else {
            throw QuizServiceError.invalidEncoding
        }
        
        do {
            let response = try JSONDecoder().decode(QuizResponse.self, from: data)
            return response.quiz
        } catch {
            throw QuizServiceError.decoding(error)
        }
    }
}

enum QuizServiceError: Error {
    case invalidData
    case invalidEncoding
    case decoding(Error)
}
