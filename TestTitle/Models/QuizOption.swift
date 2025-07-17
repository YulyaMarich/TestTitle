//
//  QuizOption.swift
//  TestTitle
//
//  Created by Yuliia Marych on 17.07.2025.
//

import SwiftUI

struct QuizOption: Decodable, Identifiable, Equatable {
    let id: String
    let title: String
    let subtitle: String?
    let imageUrl: String?
    let color: Color?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case subtitle
        case imageUrl
        case hex
    }
    
    init(id: Int, title: String, subtitle: String?, imageUrl: String?, hex: String?) {
        self.id = String(id)
        self.title = title
        self.subtitle = subtitle
        self.imageUrl = imageUrl
        self.color = Color(hex: hex ?? "")
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = String(try container.decode(Int.self, forKey: .id))
        self.title = try container.decode(String.self, forKey: .title)
        self.subtitle = try container.decodeIfPresent(String.self, forKey: .subtitle)
        self.imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
        if let hex = try container.decodeIfPresent(String.self, forKey: .hex) {
            self.color = Color(hex: hex)
        } else {
            self.color = nil
        }
    }
    
    func toStylistFocusOption() -> StylistFocusOption? {
        guard let subtitle else { return nil }
        return StylistFocusOption(id: id, title: title, subtitle: subtitle)
    }
    
    func toStyleOption() -> StyleOption? {
        if let imageUrl, let url = URL(string: imageUrl) {
            return StyleOption(id: id, title: title, imageURL: url)
        } else {
            return nil
        }
    }
    
    func toColorOption() -> ColorOption? {
        guard let color else { return nil }
        return ColorOption(id: id, title: title, color: color)
    }
}
