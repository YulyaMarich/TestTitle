//
//  StyleGridView.swift
//  TestTitle
//
//  Created by Yuliia Marych on 17.07.2025.
//

import SwiftUI

struct StyleGridUIConfiguration {
    static let spacing: CGFloat = 12
    static let height: CGFloat = 162
}

struct StyleOption: Identifiable, Equatable {
    let id: String
    let title: String
    let imageURL: URL?
}

struct StyleGridView: View {
    let options: [StyleOption]
    let selectedIDs: Set<String>
    let onTap: (String) -> Void
    
    private let columns = [
        GridItem(.flexible(), spacing: StyleGridUIConfiguration.spacing),
        GridItem(.flexible(), spacing: StyleGridUIConfiguration.spacing)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: StyleGridUIConfiguration.spacing) {
            ForEach(options) { option in
                StyleOptionView(
                    isSelected: selectedIDs.contains(option.id),
                    imageURL: option.imageURL,
                    title: option.title,
                    onTap: {
                        onTap(option.id)
                    }
                )
            }
            .frame(height: StyleGridUIConfiguration.height)
        }
    }
}
