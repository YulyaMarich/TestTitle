//
//  StyleOptionView.swift
//  TestTitle
//
//  Created by Yuliia Marych on 17.07.2025.
//

import SwiftUI

struct StyleOptionView: View {
    var isSelected: Bool
    var imageURL: URL?
    var title: String
    var onTap: () -> Void
    
    var body: some View {
        SelectableCard(isSelected: isSelected) {
            VStack(spacing: 4) {
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
                                    .scaledToFill()
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
                        .frame(width: 20, height: 20)
                    }
                }
                
                Text(title.uppercased())
                    .font(.poppins(size: 13, weight: isSelected ? .medium : .light))
                    .foregroundColor(.textPrimary)
                    .multilineTextAlignment(.center)
            }
            .padding(8)
        } onTap: {
            onTap()
        }
    }
}
