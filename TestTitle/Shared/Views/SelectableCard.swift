//
//  SelectableCard.swift
//  TestTitle
//
//  Created by Yuliia Marych on 16.07.2025.
//

import SwiftUI

struct SelectableCardUIConfiguration {
    static let cornerRadius: CGFloat = 0
    static let strokeWidth: CGFloat = 0.5
    static let animationDuration: Double = 0.2
}

struct SelectableCard<Content: View>: View {
    var isSelected: Bool
    let content: () -> Content
    let onTap: () -> Void
    
    var body: some View {
        content()
            .frame(maxWidth: .infinity, alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: SelectableCardUIConfiguration.cornerRadius)
                    .stroke(isSelected ? Color.strokePrimary : Color.strokeSecondary, lineWidth: SelectableCardUIConfiguration.strokeWidth)
            )
            .animation(.easeInOut(duration: SelectableCardUIConfiguration.animationDuration), value: isSelected)
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation {
                    onTap()
                }
            }
    }
}
