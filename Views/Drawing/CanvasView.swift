//
//  SwiftUIView.swift
//  
//
//  Created by Brayton Lordianto on 4/14/23.
//

import SwiftUI
import PencilKit

struct CanvasView: View {
    @StateObject var drawingViewModel: DrawingViewModel
    var body: some View {
        CanvasRepresentable(drawingViewModel: drawingViewModel)
    }
}

// canvas representable 
struct CanvasRepresentable: UIViewRepresentable {
    @ObservedObject var drawingViewModel: DrawingViewModel

    func makeUIView(context: Context) -> PKCanvasView {
        drawingViewModel.initializeCanvas()
        // Set the drawingPolicy to .anyInput
        drawingViewModel.drawingModel.canvas.drawingPolicy = .anyInput

        return drawingViewModel.drawingModel.canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
    }
}


struct CanvasView_Previews: PreviewProvider {
    @StateObject var drawingViewModel = DrawingViewModel()
    static var previews: some View {
        CanvasRepresentable(drawingViewModel: DrawingViewModel())
    }
}
