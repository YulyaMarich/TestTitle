//
//  QuizDataService+Dependency.swift
//  TestTitle
//
//  Created by Yuliia Marych on 17.07.2025.
//

import Dependencies

enum QuizServiceKey: DependencyKey {
    static var liveValue: QuizService = QuizServiceImpl()
    static var testValue: QuizService = MockQuizServiceImpl()
    static var previewValue: QuizService = MockQuizServiceImpl()
}

extension DependencyValues {
    var quizService: QuizService {
        get { self[QuizServiceKey.self] }
        set { self[QuizServiceKey.self] = newValue }
    }
}
