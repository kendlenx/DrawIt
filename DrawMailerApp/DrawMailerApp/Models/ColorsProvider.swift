//
//  ColorsProvider.swift
//  DrawMailerApp
//
//  Created by Aysegul Akpinarli (RIT Student) on 06.12.2024..
//

import SwiftUI

struct ColorInfo: Identifiable {
    let id: Int
    let displayName: String
    let color: Color
}

class ColorsProvider {
    static func supportedColors() -> [ColorInfo] {
        return [
            ColorInfo(id: 1, displayName: "Black", color: .black),
            ColorInfo(id: 2, displayName: "Blue", color: .blue),
            ColorInfo(id: 3, displayName: "Red", color: .red),
            ColorInfo(id: 4, displayName: "Green", color: .green),
            ColorInfo(id: 5, displayName: "Yellow", color: .yellow),
            ColorInfo(id: 6, displayName: "Orange", color: .orange),
            ColorInfo(id: 7, displayName: "Gray", color: .gray),
            ColorInfo(id: 8, displayName: "Purple", color: .purple),
            ColorInfo(id: 9, displayName: "Pink", color: .pink),
            ColorInfo(id: 10, displayName: "White", color: .white)
        ]
    }
}
