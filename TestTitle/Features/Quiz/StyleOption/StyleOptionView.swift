//
//  StyleOptionView.swift
//  TestTitle
//
//  Created by Yuliia Marych on 17.07.2025.
//

import SwiftUI

struct StyleOptionUIConfiguration {
    static let vStackSpacing: CGFloat = 4
    static let padding: CGFloat = 8
    static let checkboxSize: CGFloat = 20
    static let titleFontSize: CGFloat = 13
}

struct StyleOptionView: View {
    var isSelected: Bool
    var imageURL: URL?
    var title: String
    var onTap: () -> Void
    
    var body: some View {
        SelectableCard(isSelected: isSelected) {
            VStack(spacing: StyleOptionUIConfiguration.vStackSpacing) {
                GeometryReader { geo in
                    ZStack(alignment: .topTrailing) {
                        AsyncImage(url: imageURL) { phase in
                            switch phase {
                            case .empty:
                                Color.clear
                                    .overlay(ProgressView(), alignment: .center)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geo.size.width, height: geo.size.height)
                                    .clipped()
                                
                            case .failure:
                                Color.gray
                                    .overlay(Image(systemName: "photo"))
                            @unknown default:
                                EmptyView()
                            }
                        }
                        
                        CheckBoxView(isChecked: isSelected) {
                            onTap()
                        }
                        .frame(width: StyleOptionUIConfiguration.checkboxSize, height: StyleOptionUIConfiguration.checkboxSize)
                    }
                }
                
                Text(title.uppercased())
                    .font(.poppins(size: StyleOptionUIConfiguration.titleFontSize, weight: isSelected ? .medium : .light))
                    .foregroundColor(.textPrimary)
                    .multilineTextAlignment(.center)
            }
            .padding(StyleOptionUIConfiguration.padding)
        } onTap: {
            onTap()
        }
    }
}
