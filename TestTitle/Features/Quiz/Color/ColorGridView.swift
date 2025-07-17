//
//  ColorGridView.swift
//  TestTitle
//
//  Created by Yuliia Marych on 17.07.2025.
//

import SwiftUI

struct ColorOption: Identifiable, Equatable {
    let id: String
    let title: String
    let color: Color
}

struct ColorGridView: View {
    let options: [ColorOption]
    let selectedIDs: Set<String>
    let onTap: (String) -> Void
    
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(options) { option in
                ColorOptionView(
                    color: option.color,
                    title: option.title,
                    isSelected: selectedIDs.contains(option.id),
                    onTap: {
                        onTap(option.id)
                    }
                )
            }
            .aspectRatio(1, contentMode: .fit)
        }
    }
}
