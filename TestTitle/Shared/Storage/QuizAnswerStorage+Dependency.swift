//
//  QuizAnswerStorage+Dependency.swift
//  TestTitle
//
//  Created by Yuliia Marych on 17.07.2025.
//

import Dependencies

private enum QuizAnswerStorageKey: DependencyKey {
    static let liveValue: QuizAnswerStorage = QuizAnswerStorageImpl()
}

extension DependencyValues {
    var quizAnswerStorage: QuizAnswerStorage {
        get { self[QuizAnswerStorageKey.self] }
        set { self[QuizAnswerStorageKey.self] = newValue }
    }
}
