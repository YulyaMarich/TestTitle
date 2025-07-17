//
//  QuizStep.swift
//  TestTitle
//
//  Created by Yuliia Marych on 17.07.2025.
//

import Foundation

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

extension QuizStep {
    var viewStep: QuizViewStep {
        switch type {
        case "stylist_focus": .stylistFocus
        case "style": .style
        case "colors": .colors
        default: .stylistFocus
        }
    }
}
