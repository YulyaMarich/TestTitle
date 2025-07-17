//
//  QuizViewStep.swift
//  TestTitle
//
//  Created by Yuliia Marych on 17.07.2025.
//

import Foundation

enum QuizViewStep: Equatable, Identifiable {
    case stylistFocus
    case style
    case colors
    
    var id: Self { self }
}
