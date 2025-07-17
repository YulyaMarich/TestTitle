//
//  QuizDataService.swift
//  TestTitle
//
//  Created by Yuliia Marych on 17.07.2025.
//

import Foundation

protocol QuizService {
    func fetchQuiz() async throws -> [QuizStep]
}

final class QuizServiceImpl: QuizService {
    
    func fetchQuiz() async throws -> [QuizStep] {
        return []
    }
}
