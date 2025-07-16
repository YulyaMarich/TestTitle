//
//  CheckBoxView.swift
//  TestTitle
//
//  Created by Yuliia Marych on 16.07.2025.
//

import SwiftUI

struct CheckBoxView: View {
    let isChecked: Bool
    let onTap: () -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(isChecked ? Color.surfaceAccent : Color.clear)
                .overlay(
                    Rectangle()
                        .stroke(isChecked ? Color.surfaceAccent : Color.strokeSeparator, lineWidth: 1)
                )
            
            if isChecked {
                Image("checkmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 14, height: 14)
                    .animation(.easeInOut(duration: 0.2), value: isChecked)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: isChecked)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation {
                onTap()
            }
        }
    }
}
