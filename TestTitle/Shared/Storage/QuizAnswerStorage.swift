//
//  QuizAnswerStorage.swift
//  TestTitle
//
//  Created by Yuliia Marych on 17.07.2025.
//

import Foundation

struct QuizAnswer: Equatable, Codable {
    let questionID: Int
    let selectedOptionIDs: [Int]
}

protocol QuizAnswerStorage {
    func save(_ answer: QuizAnswer) throws
    func loadAll() throws -> [QuizAnswer]
    func clear() throws
}

final class QuizAnswerStorageImpl: QuizAnswerStorage {
    private static let key = "quizAnswers"
    private let defaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.defaults = userDefaults
    }
    
    func save(_ answer: QuizAnswer) throws {
        var current = try loadAll()
        current.removeAll { $0.questionID == answer.questionID }
        current.append(answer)
        let data = try JSONEncoder().encode(current)
        defaults.set(data, forKey: QuizAnswerStorageImpl.key)
    }
    
    func loadAll() throws -> [QuizAnswer] {
        guard let data = defaults.data(forKey: QuizAnswerStorageImpl.key) else { return [] }
        return try JSONDecoder().decode([QuizAnswer].self, from: data)
    }
    
    func clear() throws {
        defaults.removeObject(forKey: QuizAnswerStorageImpl.key)
    }
}
