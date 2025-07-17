//
//  StylistFocusOptionView.swift
//  TestTitle
//
//  Created by Yuliia Marych on 17.07.2025.
//

import SwiftUI

struct StylistFocusOptionUIConfiguration {
    static let hStackSpacing: CGFloat = 15
    static let vStackSpacing: CGFloat = 8
    static let horizontalPadding: CGFloat = 16
    static let verticalPadding: CGFloat = 15
    static let height: CGFloat = 72
    static let checkboxSize: CGFloat = 20
    static let titleFontSize: CGFloat = 13
    static let subtitleFontSize: CGFloat = 12
    static let minimumScaleFactor: CGFloat = 0.01
}

struct StylistFocusOptionView: View {
    var isSelected: Bool
    var title: String
    var subtitle: String
    var onTap: () -> Void
    
    var body: some View {
        SelectableCard(isSelected: isSelected) {
            HStack(spacing: StylistFocusOptionUIConfiguration.hStackSpacing) {
                VStack(alignment: .leading, spacing: StylistFocusOptionUIConfiguration.vStackSpacing) {
                    Text(title.uppercased())
                        .font(.poppins(size: StylistFocusOptionUIConfiguration.titleFontSize, weight: .medium))
                    
                    Text(subtitle.uppercased())
                        .font(.poppins(size: StylistFocusOptionUIConfiguration.subtitleFontSize))
                        .minimumScaleFactor(StylistFocusOptionUIConfiguration.minimumScaleFactor)
                        .lineLimit(1)
                        .layoutPriority(1)
                }
                
                Spacer(minLength: 0)
                
                CheckBoxView(isChecked: isSelected) {
                    onTap()
                }
                .frame(width: StylistFocusOptionUIConfiguration.checkboxSize, height: StylistFocusOptionUIConfiguration.checkboxSize)
            }
            .padding(.horizontal, StylistFocusOptionUIConfiguration.horizontalPadding)
            .padding(.vertical, StylistFocusOptionUIConfiguration.verticalPadding)
            .frame(height: StylistFocusOptionUIConfiguration.height)
        } onTap: {
            onTap()
        }
    }
}
