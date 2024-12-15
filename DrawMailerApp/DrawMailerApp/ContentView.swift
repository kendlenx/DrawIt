//
//  ContentView.swift
//  DrawMailerApp
//
//  Created by Aysegul Akpinarli (RIT Student) on 06.12.2024..
//

import SwiftUI

struct ContentView: View {
    @State private var currentDrawing = Drawing()
    @State private var drawings = [Drawing]()
    @State private var color: Color = .black
    @State private var lineWidth: CGFloat = 3.0
    @State private var background: Color = .white
    @State private var uiImage: UIImage? = nil
    @State private var drawingRect: CGRect = .zero

    var body: some View {
        VStack {
            DrawingPad(currentDrawing: $currentDrawing, drawings: $drawings, color: $color, background: $background, lineWidth: $lineWidth)
                .background(background)
                .background(RectGetter(rect: $drawingRect))
            DrawingControls(color: $color, drawings: $drawings, lineWidth: $lineWidth, uiImage: $uiImage, drawingRect: $drawingRect, background: $background)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}


#Preview {
    ContentView()
}
