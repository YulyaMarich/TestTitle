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
            return .buttonSurfaceDarkMode
        case .dark:
            return .buttonSurfacePrimary
        }
    }
    
    var titleColor: Color {
        switch self {
        case .light:
            return .textPrimary
        case .dark:
            return .textDarkMode
        }
    }
}

struct PrimaryButton: View {
    let title: String
    let buttonType: PrimaryButtonType
    let isEnabled: Bool
    let action: () -> Void

    init(
        title: String,
        buttonType: PrimaryButtonType,
        isEnabled: Bool = true,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.buttonType = buttonType
        self.isEnabled = isEnabled
        self.action = action
    }

    var body: some View {
        Button {
            if isEnabled {
                action()
            }
        } label: {
            Text(title.uppercased())
                .font(.poppins(size: 14, weight: .regular))
                .foregroundStyle(buttonType.titleColor)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    (isEnabled ? buttonType.backgroundColor : .gray.opacity(0.8))
                        .cornerRadius(4)
                )
                .contentShape(Rectangle())
        }
        .buttonStyle(PrimaryButtonStyle(isEnabled: isEnabled))
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    let pressedScale: CGFloat
    let animationDuration: CGFloat
    let isEnabled: Bool

    public init(
        pressedScale: CGFloat = 0.95,
        animationDuration: CGFloat = 0.15,
        isEnabled: Bool = true
    ) {
        self.pressedScale = pressedScale
        self.animationDuration = animationDuration
        self.isEnabled = isEnabled
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed && isEnabled ? pressedScale : 1.0)
            .animation(
                isEnabled ? .spring(duration: animationDuration) : nil,
                value: configuration.isPressed
            )
    }
}
