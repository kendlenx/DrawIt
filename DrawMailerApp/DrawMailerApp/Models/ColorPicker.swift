//
//  ColorPicker.swift
//  DrawMailerApp
//
//  Created by Aysegul Akpinarli (RIT Student) on 06.12.2024..
//

import SwiftUI

struct ColorPicker: View {
    @Binding var color: Color
    @Binding var colorPickerShown: Bool

    var body: some View {
        List(ColorsProvider.supportedColors()) { colorInfo in
            HStack {
                Circle()
                    .fill(colorInfo.color)
                    .frame(width: 40, height: 40)
                Text(colorInfo.displayName)
            }
            .onTapGesture {
                color = colorInfo.color
                colorPickerShown = false
            }
        }
    }
}
