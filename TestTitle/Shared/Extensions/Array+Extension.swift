//
//  Array+Extension.swift
//  TestTitle
//
//  Created by Yuliia Marych on 17.07.2025.
//

extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
