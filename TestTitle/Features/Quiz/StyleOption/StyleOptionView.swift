//
//  StyleOptionView.swift
//  TestTitle
//
//  Created by Yuliia Marych on 17.07.2025.
//

import SwiftUI

struct StyleOptionView: View {
    var isSelected: Bool
    var image: UIImage
    var title: String
    var onTap: () -> Void
    
    var body: some View {
        SelectableCard(isSelected: isSelected) {
            ZStack(alignment: .topTrailing) {
                VStack(spacing: 4) {
                    GeometryReader { geo in
                        ZStack(alignment: .topTrailing) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: geo.size.width, height: geo.size.height)
                                .clipped()
                            
                            CheckBoxView(isChecked: isSelected) {
                                onTap()
                            }
                            .frame(width: 20, height: 20)
                        }
                    }
                    
                    Text(title.uppercased())
                        .font(.poppins(size: 13, weight: isSelected ? .medium : .light))
                        .foregroundColor(.textPrimary)
                        .multilineTextAlignment(.center)
                }
                .padding(8)
            }
        } onTap: {
            onTap()
        }
    }
}
