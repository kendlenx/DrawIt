import SwiftUI

struct Drawing: Identifiable {
    let id = UUID()
    var points: [CGPoint] = []
    var color: Color = .black
    var lineWidth: CGFloat = 1.0 
}

struct DrawingPad: View {
    @Binding var currentDrawing: Drawing
    @Binding var drawings: [Drawing]
    @Binding var color: Color
    @Binding var background: Color
    @Binding var lineWidth: CGFloat

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                background
                    .edgesIgnoringSafeArea(.all)
                ForEach(drawings) { drawing in
                    Path { path in
                        add(drawing: drawing, toPath: &path)
                    }
                    .stroke(drawing.color, lineWidth: drawing.lineWidth)
                }

                Path { path in
                    add(drawing: currentDrawing, toPath: &path)
                }
                .stroke(color, lineWidth: lineWidth)
            }
            .background(Color(white: 0.95))
            .gesture(
                DragGesture(minimumDistance: 0.1)
                    .onChanged { value in
                        let currentPoint = value.location
                        if currentPoint.y >= 0 && currentPoint.y < geometry.size.height {
                            currentDrawing.points.append(currentPoint)
                        }
                    }
                    .onEnded { _ in
                        currentDrawing.color = color
                        currentDrawing.lineWidth = lineWidth
                        drawings.append(currentDrawing)
                        currentDrawing = Drawing()
                    }
            )
        }
    }

    private func add(drawing: Drawing, toPath path: inout Path) {
        guard drawing.points.count > 1 else { return }
        for i in 0..<drawing.points.count-1 {
            path.move(to: drawing.points[i])
            path.addLine(to: drawing.points[i+1])
        }
    }
}
