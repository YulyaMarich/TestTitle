//
//  StylistFocusOptionView.swift
//  TestTitle
//
//  Created by Yuliia Marych on 17.07.2025.
//

import SwiftUI

struct StylistFocusOptionView: View {
    var isSelected: Bool
    var title: String
    var subtitle: String
    var onTap: () -> Void
    
    var body: some View {
        SelectableCard(isSelected: isSelected) {
            HStack(spacing: 15) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(title.uppercased())
                        .font(.poppins(size: 13, weight: .medium))
                    
                    Text(subtitle.uppercased())
                        .font(.poppins(size: 12))
                        .minimumScaleFactor(0.01)
                        .lineLimit(1)
                        .layoutPriority(1)
                }
                
                Spacer(minLength: 0)
                
                CheckBoxView(isChecked: isSelected) {
                    onTap()
                }
                .frame(width: 20, height: 20)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 15)
            .frame(height: 72)
        } onTap: {
            onTap()
        }
    }
}
