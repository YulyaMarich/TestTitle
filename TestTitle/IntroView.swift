//
//  IntroView.swift
//  TestTitle
//
//  Created by Yuliia Marych on 15.07.2025.
//

import SwiftUI

struct IntroUIConfiguration {
    static let horizontalPadding: CGFloat = 20
    static let bottomTextPadding: CGFloat = 61
    static let bottomButtonPadding: CGFloat = 62
    static let buttonHeight: CGFloat = 42
    
    static let gradientStops: [Gradient.Stop] = [
        .init(color: Color.black.opacity(0), location: 0.2992),
        .init(color: Color.black, location: 0.8092)
    ]
    
    static let titleFontSize: CGFloat = 32
}

struct IntroView: View {
    
    var body: some View {
        ZStack {
            Image("introBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .overlay(backgroundGradient)
            
            VStack {
                Spacer()
                
                Text("Online Personal \nStyling. \nOutfits for \nEvery Woman.")
                    .multilineTextAlignment(.leading)
                    .font(.kaiseiTokumin(size: IntroUIConfiguration.titleFontSize))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .padding(.bottom, IntroUIConfiguration.bottomTextPadding)
                
                PrimaryButton(
                    title: "Take a quiz",
                    buttonType: .light,
                    action: {}
                )
                .frame(height: IntroUIConfiguration.buttonHeight)
                .padding(.bottom, IntroUIConfiguration.bottomButtonPadding)
                
            }
            .padding(.horizontal, IntroUIConfiguration.horizontalPadding)
        }
    }
    
    private var backgroundGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(stops: IntroUIConfiguration.gradientStops),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

#Preview {
    IntroView()
}

