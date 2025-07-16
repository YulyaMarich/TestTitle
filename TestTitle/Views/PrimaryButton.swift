//
//  PrimaryButton.swift
//  TestTitle
//
//  Created by Yuliia Marych on 16.07.2025.
//

import SwiftUI

enum PrimaryButtonType {
    case light, dark
    
    var backgroundColor: Color {
        switch self {
        case .light:
            return .buttonSurfacePrimary
        case .dark:
            return .buttonSurfaceDarkMode
        }
    }
    
    var titleColor: Color {
        switch self {
        case .light:
            return .textDarkMode
        case .dark:
            return .textPrimary
        }
    }
}

struct PrimaryButton: View {
    let title: String
    let buttonType: PrimaryButtonType
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title.uppercased())
                .font(.poppins(size: 14, weight: .regular))
                .foregroundStyle(buttonType.titleColor)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(buttonType.backgroundColor.cornerRadius(4))
                .contentShape(Rectangle())
        }
        .buttonStyle(PrimaryButtonStyle())
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    let pressedScale: CGFloat
    let animationDuration: CGFloat
    
    public init(pressedScale: CGFloat = 0.95, animationDuration: CGFloat = 0.2) {
        self.pressedScale = pressedScale
        self.animationDuration = animationDuration
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? pressedScale : 1.0)
            .animation(.spring(duration: animationDuration), value: configuration.isPressed)
    }
}
