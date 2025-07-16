//
//  SelectableCard.swift
//  TestTitle
//
//  Created by Yuliia Marych on 16.07.2025.
//

import SwiftUI

struct SelectableCard<Content: View>: View {
    var isSelected: Bool
    let content: () -> Content
    let onTap: () -> Void
    
    var body: some View {
        content()
            .frame(maxWidth: .infinity, alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: 0)
                    .stroke(isSelected ? Color.strokePrimary : Color.strokeSecondary, lineWidth: 1)
            )
            .animation(.easeInOut(duration: 0.2), value: isSelected)
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation {
                    onTap()
                }
            }
    }
}
