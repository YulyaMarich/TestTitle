//
//  StylistFocusListView.swift
//  TestTitle
//
//  Created by Yuliia Marych on 17.07.2025.
//

import SwiftUI

struct StylistFocusOption: Identifiable, Equatable {
    let id: String
    let title: String
    let subtitle: String
}

struct StylistFocusListView: View {
    let options: [StylistFocusOption]
    let selectedIDs: Set<String>
    let onTap: (String) -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            ForEach(options) { option in
                StylistFocusOptionView(
                    isSelected: selectedIDs.contains(option.id),
                    title: option.title,
                    subtitle: option.subtitle,
                    onTap: {
                        onTap(option.id)
                    }
                )
            }
        }
    }
}
