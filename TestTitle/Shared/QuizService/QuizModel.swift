//
//  QuizModel.swift
//  TestTitle
//
//  Created by Yuliia Marych on 17.07.2025.
//

import Foundation

enum SelectionMode: String, Decodable, Equatable {
    case single
    case multi
}

struct QuizResponse: Decodable {
    let quiz: [QuizStep]
}

struct QuizStep: Decodable, Identifiable, Equatable {
    let id: Int
    let type: String
    let selectionMode: SelectionMode
    let title: String
    let subtitle: String?
    let options: [QuizOption]
}

struct QuizOption: Decodable, Identifiable, Equatable {
    let id: Int
    let title: String
    let subtitle: String?
    let imageUrl: String?
    let hex: String?
}
