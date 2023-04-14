//
//  SwiftUIView.swift
//  
//
//  Created by Brayton Lordianto on 4/14/23.
//

import SwiftUI
import PencilKit

struct CanvasComponent: View {
    @StateObject var drawingViewModel = DrawingViewModel()
    var body: some View {
        CanvasRepresentable(drawingViewModel: drawingViewModel)
    }
}

// canvas representable 
struct CanvasRepresentable: UIViewRepresentable {
    @ObservedObject var drawingViewModel: DrawingViewModel
    func makeUIView(context: Context) -> PKCanvasView {
        return drawingViewModel.drawingModel.canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        drawingViewModel.updateCanvasTool()
    }
}
