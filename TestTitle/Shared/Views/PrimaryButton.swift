//
//  PrimaryButton.swift
//  TestTitle
//
//  Created by Yuliia Marych on 16.07.2025.
//

import SwiftUI

struct PrimaryButtonUIConfiguration {
    static let fontSize: CGFloat = 14
    static let cornerRadius: CGFloat = 4
    static let disabledOpacity: Double = 0.8
    static let progressViewScale: CGFloat = 0.8
    static let pressedScale: CGFloat = 0.95
    static let animationDuration: CGFloat = 0.15
}

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
    let isLoading: Bool
    let action: () -> Void
    
    init(
        title: String,
        buttonType: PrimaryButtonType,
        isEnabled: Bool = true,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.buttonType = buttonType
        self.isEnabled = isEnabled
        self.isLoading = isLoading
        self.action = action
    }
    
    var body: some View {
        Button {
            if isEnabled && !isLoading {
                action()
            }
        } label: {
            ZStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: buttonType.titleColor))
                        .scaleEffect(PrimaryButtonUIConfiguration.progressViewScale)
                } else {
                    Text(title.uppercased())
                        .font(.poppins(size: PrimaryButtonUIConfiguration.fontSize, weight: .regular))
                        .foregroundStyle(buttonType.titleColor)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                (isEnabled ? buttonType.backgroundColor : .gray.opacity(PrimaryButtonUIConfiguration.disabledOpacity))
                    .cornerRadius(PrimaryButtonUIConfiguration.cornerRadius)
            )
            .contentShape(Rectangle())
        }
        .buttonStyle(PrimaryButtonStyle(isEnabled: isEnabled && !isLoading))
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    let pressedScale: CGFloat
    let animationDuration: CGFloat
    let isEnabled: Bool
    
    public init(
        pressedScale: CGFloat = PrimaryButtonUIConfiguration.pressedScale,
        animationDuration: CGFloat = PrimaryButtonUIConfiguration.animationDuration,
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
