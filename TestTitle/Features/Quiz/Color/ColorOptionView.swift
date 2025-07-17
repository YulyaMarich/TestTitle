//
//  ColorOptionView.swift
//  TestTitle
//
//  Created by Yuliia Marych on 17.07.2025.
//

import SwiftUI

struct ColorOptionView: View {
    let color: Color
    let title: String
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        SelectableCard(isSelected: isSelected) {
            ZStack(alignment: .topTrailing) {
                VStack(spacing: 8) {
                    color
                        .frame(width: 32, height: 32)
                    
                    Text(title.uppercased())
                        .font(.poppins(size: 13, weight: isSelected ? .medium : .light))
                        .foregroundColor(.textPrimary)
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                        .minimumScaleFactor(0.01)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 16)
                
                CheckBoxView(isChecked: isSelected) {
                    onTap()
                }
                .frame(width: 20, height: 20)
                .opacity(isSelected ? 1 : 0)
            }
            .padding(8)
        } onTap: {
            onTap()
        }
    }
}
