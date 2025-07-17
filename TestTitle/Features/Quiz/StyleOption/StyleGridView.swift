//
//  StyleGridView.swift
//  TestTitle
//
//  Created by Yuliia Marych on 17.07.2025.
//

import SwiftUI

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
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {
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
            .frame(height: 162)
        }
    }
}
