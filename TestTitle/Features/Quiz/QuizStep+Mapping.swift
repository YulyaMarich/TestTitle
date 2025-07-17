//
//  QuizStep+Mapping.swift
//  TestTitle
//
//  Created by Yuliia Marych on 17.07.2025.
//

import SwiftUI

extension QuizStep {
    var viewStep: QuizViewStep {
        switch type {
        case "stylist_focus": .stylistFocus
        case "style": .style
        case "colors": .colors
        default: .stylistFocus
        }
    }
    
    var stylistFocusOptions: [StylistFocusOption]? {
        guard type == "stylist_focus" else { return nil }
        return options.compactMap {
            guard let subtitle = $0.subtitle else { return nil }
            return StylistFocusOption(
                id: String($0.id),
                title: $0.title,
                subtitle: subtitle
            )
        }
    }
    
    var styleOptions: [StyleOption]? {
        guard type == "style" else { return nil }
        return options.map {
            StyleOption(
                id: String($0.id),
                title: $0.title,
                imageURL: URL(string: $0.imageUrl ?? "")
            )
        }
    }
    
    var colorOptions: [ColorOption]? {
        guard type == "colors" else { return nil }
        return options.compactMap {
            guard let hex = $0.hex else { return nil }
            return ColorOption(
                id: String($0.id),
                title: $0.title,
                color: Color(hex: hex) ?? .pink
            )
        }
    }
}
