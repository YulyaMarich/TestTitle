//
//  MockQuizService.swift
//  TestTitle
//
//  Created by Yuliia Marych on 17.07.2025.
//

import Foundation

final class MockQuizServiceImpl: QuizService {
    func fetchQuiz() async throws -> [QuizStep] {
        try await Task.sleep(nanoseconds: 500_000_000)
        
        return [
            QuizStep(
                id: 1,
                type: "stylist_focus",
                selectionMode: .multiple,
                title: "What’d you like our stylists to focus on?",
                subtitle: "We offer services via live-chat mode.",
                options: [
                    QuizOption(id: 1, title: "REINVENT WARDROBE", subtitle: "to discover fresh outfit ideas", imageUrl: nil, hex: nil),
                    QuizOption(id: 2, title: "DEFINE COLOR PALETTE", subtitle: "to enhance my natural features", imageUrl: nil, hex: nil),
                    QuizOption(id: 3, title: "CREATE A SEASONAL CAPSULE", subtitle: "to curate effortless and elegant looks", imageUrl: nil, hex: nil),
                    QuizOption(id: 4, title: "DEFINE MY STYLE", subtitle: "to discover my signature look", imageUrl: nil, hex: nil),
                    QuizOption(id: 5, title: "CREATE AN OUTFIT FOR AN EVENT", subtitle: "to own a spotlight wherever you go", imageUrl: nil, hex: nil)
                ]
            ),
            QuizStep(
                id: 2,
                type: "style",
                selectionMode: .single,
                title: "Which style best represents you?",
                subtitle: nil,
                options: [
                    QuizOption(id: 1, title: "CASUAL", subtitle: nil, imageUrl: "https://i.ibb.co/8y2hBBw/Rectangle-4337-2x.png", hex: nil),
                    QuizOption(id: 2, title: "BOHO", subtitle: nil, imageUrl: "https://i.ibb.co/MDV2KsgF/Rectangle-4337-2x.png", hex: nil),
                    QuizOption(id: 3, title: "CLASSY", subtitle: nil, imageUrl: "https://i.ibb.co/Qv80xFKG/Rectangle-4337-2x.png", hex: nil),
                    QuizOption(id: 4, title: "LADYLIKE", subtitle: nil, imageUrl: "https://i.ibb.co/MDV2KsgF/Rectangle-4337-2x.png", hex: nil),
                    QuizOption(id: 5, title: "URBAN", subtitle: nil, imageUrl: "https://i.ibb.co/Yq363LL/Rectangle-4337-2x.png", hex: nil),
                    QuizOption(id: 6, title: "SPORTY", subtitle: nil, imageUrl: "https://i.ibb.co/RkqdnGzy/Rectangle-4337-2x.png", hex: nil)
                ]
            ),
            QuizStep(
                id: 3,
                type: "colors",
                selectionMode: .multiple,
                title: "Choose favourite colors",
                subtitle: nil,
                options: [
                    QuizOption(id: 1, title: "LIGHT BLUE", subtitle: nil, imageUrl: nil, hex: "#ABE2FF"),
                    QuizOption(id: 2, title: "BLUE", subtitle: nil, imageUrl: nil, hex: "#5EA8FF"),
                    QuizOption(id: 3, title: "INDIGO", subtitle: nil, imageUrl: nil, hex: "#2237A8"),
                    QuizOption(id: 4, title: "TURQUOISE", subtitle: nil, imageUrl: nil, hex: "#69D1ED"),
                    QuizOption(id: 5, title: "MINT", subtitle: nil, imageUrl: nil, hex: "#87DBC8"),
                    QuizOption(id: 6, title: "OLIVE", subtitle: nil, imageUrl: nil, hex: "#A8AD49"),
                    QuizOption(id: 7, title: "GREEN", subtitle: nil, imageUrl: nil, hex: "#29AD3E"),
                    QuizOption(id: 8, title: "EMERALD", subtitle: nil, imageUrl: nil, hex: "#098052"),
                    QuizOption(id: 9, title: "YELLOW", subtitle: nil, imageUrl: nil, hex: "#EDDD47"),
                    QuizOption(id: 10, title: "BEIGE", subtitle: nil, imageUrl: nil, hex: "#CA9675"),
                    QuizOption(id: 11, title: "ORANGE", subtitle: nil, imageUrl: nil, hex: "#CD6A09"),
                    QuizOption(id: 12, title: "BROWN", subtitle: nil, imageUrl: nil, hex: "#7F4B03"),
                    QuizOption(id: 13, title: "PINK", subtitle: nil, imageUrl: nil, hex: "#FF86B8"),
                    QuizOption(id: 14, title: "MAGENTA", subtitle: nil, imageUrl: nil, hex: "#CF236E"),
                    QuizOption(id: 15, title: "RED", subtitle: nil, imageUrl: nil, hex: "#D31E1E")
                ]
            )
        ]
    }
}
