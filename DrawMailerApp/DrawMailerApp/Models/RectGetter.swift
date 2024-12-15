//
//  RectGetter.swift
//  DrawMailerApp
//
//  Created by Aysegul Akpinarli (RIT Student) on 06.12.2024..
//

import SwiftUI

struct RectGetter: View {
    @Binding var rect: CGRect
    var body: some View {
        GeometryReader { proxy in
            Color.clear.onAppear {
                rect = proxy.frame(in: .global)
            }
        }
    }
}
