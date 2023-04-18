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
    @EnvironmentObject var paintingCollection: PaintingCollection
    var body: some View {
            VStack {
                NavigationLink {
                    ChooseFrameView(image: drawingViewModel.drawingAsImage())
                        .environmentObject(paintingCollection)
                } label: {
                    Text("Ready to add to My Collection")
                }
                .buttonStyle(.bordered)
                
                
                CanvasRepresentable(drawingViewModel: drawingViewModel)
                    .offset(y: 10)
                    .ignoresSafeArea(edges: .bottom)
                    .onAppear {
                        drawingViewModel.initializeCanvas()
                    }
            }
    }
}

// canvas representable 
struct CanvasRepresentable: UIViewRepresentable {
    @ObservedObject var drawingViewModel: DrawingViewModel

    func makeUIView(context: Context) -> PKCanvasView {
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
            .environmentObject(PaintingCollection())
    }
}
