//
//  DrawingControls.swift
//  DrawMailerApp
//
//  Created by Aysegul Akpinarli (RIT Student) on 06.12.2024..
//
import SwiftUI

struct DrawingControls: View {
    @Binding var color: Color
    @Binding var drawings: [Drawing]
    @Binding var lineWidth: CGFloat
    @Binding var uiImage: UIImage?
    @Binding var drawingRect: CGRect
    @Binding var background: Color
    
    @State private var colorPickerShown = false
    @State private var backgroundColorPickerShown = false
    @State private var showShareSheet = false
    @State private var showSaveAlert = false
    @State private var controlsVisible = true
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    Button(action: { controlsVisible.toggle() }) {
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .foregroundColor(.green)
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .padding()
                            .padding(.bottom, 20)
                    }
                }
                
                if controlsVisible {
                    VStack(spacing: 10) {
                        HStack(spacing: 30) {
                            Button(action: { colorPickerShown = true }) {
                                Image(systemName: "paintpalette")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                            }
                            
                            Button(action: { backgroundColorPickerShown = true }) {
                                Image(systemName: "photo.on.rectangle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                            }
                            
                            Button(action: { if !drawings.isEmpty { drawings.removeLast() } }) {
                                Image(systemName: "arrow.uturn.left.square")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                            }
                            
                            Button(action: {
                                drawings.removeAll()
                                background = .white
                            }) {
                                Image(systemName: "xmark.square")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                            }
                            
                            Button(action: { saveDrawing() }) {
                                Image(systemName: "square.and.arrow.down")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                            }
                            .alert(isPresented: $showSaveAlert) {
                                Alert(title: Text("Saved"), message: Text("Successfully Saved!"), dismissButton: .default(Text("OK")))
                            }
                            
                            Button(action: { shareDrawing() }) {
                                Image(systemName: "square.and.arrow.up")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        HStack {
                            Image(systemName: "pencil")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .padding(.leading, 10)
                            
                            Slider(value: $lineWidth, in: 1...15, step: 1)
                                .padding(.horizontal, 10)
                        }
                    }
                    .background(Color(UIColor.systemBackground).opacity(0.9))
                    .cornerRadius(10)
                    .padding(.bottom, 40)
                    .padding(.top, 20)
                }
            }
            .animation(.easeInOut, value: controlsVisible)
            .sheet(isPresented: $colorPickerShown) {
                ColorPicker(color: $color, colorPickerShown: $colorPickerShown)
            }
            .sheet(isPresented: $backgroundColorPickerShown) {
                ColorPicker(color: $background, colorPickerShown: $backgroundColorPickerShown)
            }
            .sheet(isPresented: $showShareSheet) {
                if let image = uiImage {
                    ShareSheet(activityItems: [image])
                }
            }
        }
    }
    
    private func saveDrawing() {
        let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
        uiImage = keyWindow?.rootViewController?.view.asImage(rect: drawingRect)
        if let image = uiImage {
            ImageSaver().writeToPhotoAlbum(image: image)
            showSaveAlert = true
        }
    }
    
    private func shareDrawing() {
        let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
        uiImage = keyWindow?.rootViewController?.view.asImage(rect: drawingRect)
        if let _ = uiImage {
            showShareSheet = true
        }
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

extension UIView {
    func asImage(rect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: rect)
        return renderer.image { ctx in
            layer.render(in: ctx.cgContext)
        }
    }
}
