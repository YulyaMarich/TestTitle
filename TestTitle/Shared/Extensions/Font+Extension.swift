//
//  Font+Extension.swift
//  TestTitle
//
//  Created by Yuliia Marych on 15.07.2025.
//

import SwiftUI

enum PoppinsFontWeight {
    case light
    case regular
    case medium
    
    fileprivate var postScriptName: String {
        switch self {
        case .light:   return "Poppins-Light"
        case .regular: return "Poppins-Regular"
        case .medium:  return "Poppins-Medium"
        }
    }
}

extension Font {
    static func poppins(size: CGFloat,
                        weight: PoppinsFontWeight = .regular) -> Font {
        .custom(weight.postScriptName, size: size)
    }
    
    static func kaiseiTokumin(size: CGFloat) -> Font {
        .custom("KaiseiTokumin-Medium", size: size)
    }
}
