//
//  SwiftUIView.swift
//  
//
//  Created by Brayton Lordianto on 4/14/23.
//

import SwiftUI
import PencilKit

struct CanvasView: View {
    @StateObject var drawingViewModel = DrawingViewModel()
    @EnvironmentObject var paintingCollection: PaintingCollection
    @State var uiimage = UIImage() 
    var body: some View {
            VStack {
                NavigationLink {
                    ChooseFrameView(image: $uiimage)
                        .environmentObject(paintingCollection)
                        .onAppear {
                            // we are using this rather than passing in the image because it has not yet been set.
                            uiimage = drawingViewModel.drawingAsImage()
                        }
                } label: {
                    Text("Ready to add to My Collection")
                }
                .buttonStyle(.bordered)
                .onTapGesture {
                    uiimage = drawingViewModel.drawingAsImage()
                }
                
                
                CanvasRepresentable(uiimage: $uiimage)
                    .environmentObject(drawingViewModel)
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
    @EnvironmentObject var drawingViewModel: DrawingViewModel
    @Binding var uiimage: UIImage

    func makeUIView(context: Context) -> PKCanvasView {
        drawingViewModel.drawingModel.canvas.drawingPolicy = .anyInput
        return drawingViewModel.drawingModel.canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
    }
}

//
//struct CanvasView_Previews: PreviewProvider {
//    @StateObject var drawingViewModel = DrawingViewModel()
//    static var previews: some View {
//        CanvasRepresentable(drawingViewModel: DrawingViewModel())
//            .environmentObject(PaintingCollection())
//    }
//}
