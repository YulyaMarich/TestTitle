//
//  CheckBoxView.swift
//  TestTitle
//
//  Created by Yuliia Marych on 16.07.2025.
//

import SwiftUI

struct CheckBoxUIConfiguration {
    static let strokeWidth: CGFloat = 1
    static let checkmarkSize: CGFloat = 14
    static let animationDuration: Double = 0.2
}

struct CheckBoxView: View {
    let isChecked: Bool
    let onTap: () -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(isChecked ? Color.surfaceAccent : Color.clear)
                .overlay(Rectangle()
                    .stroke(isChecked ? Color.surfaceAccent : Color.strokeSeparator, lineWidth: CheckBoxUIConfiguration.strokeWidth)
                )
            
            if isChecked {
                Image("checkmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: CheckBoxUIConfiguration.checkmarkSize, height: CheckBoxUIConfiguration.checkmarkSize)
                    .animation(.easeInOut(duration: CheckBoxUIConfiguration.animationDuration), value: isChecked)
            }
        }
        .animation(.easeInOut(duration: CheckBoxUIConfiguration.animationDuration), value: isChecked)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation {
                onTap()
            }
        }
    }
}
