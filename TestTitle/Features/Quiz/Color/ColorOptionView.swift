//
//  ColorOptionView.swift
//  TestTitle
//
//  Created by Yuliia Marych on 17.07.2025.
//

import SwiftUI

struct ColorOptionUIConfiguration {
    static let vStackSpacing: CGFloat = 8
    static let horizontalPadding: CGFloat = 16
    static let padding: CGFloat = 8
    static let checkboxSize: CGFloat = 20
    static let colorSize: CGFloat = 32
    static let titleFontSize: CGFloat = 13
    static let minimumScaleFactor: CGFloat = 0.01
}

struct ColorOptionView: View {
    let color: Color
    let title: String
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        SelectableCard(isSelected: isSelected) {
            ZStack(alignment: .topTrailing) {
                VStack(spacing: ColorOptionUIConfiguration.vStackSpacing) {
                    color
                        .frame(width: ColorOptionUIConfiguration.colorSize, height: ColorOptionUIConfiguration.colorSize)
                    
                    Text(title.uppercased())
                        .font(.poppins(size: ColorOptionUIConfiguration.titleFontSize, weight: isSelected ? .medium : .light))
                        .foregroundColor(.textPrimary)
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                        .minimumScaleFactor(ColorOptionUIConfiguration.minimumScaleFactor)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, ColorOptionUIConfiguration.horizontalPadding)
                
                CheckBoxView(isChecked: isSelected) {
                    onTap()
                }
                .frame(width: ColorOptionUIConfiguration.checkboxSize, height: ColorOptionUIConfiguration.checkboxSize)
                .opacity(isSelected ? 1 : 0)
            }
            .padding(ColorOptionUIConfiguration.padding)
        } onTap: {
            onTap()
        }
    }
}
