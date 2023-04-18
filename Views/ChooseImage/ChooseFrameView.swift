//
//  SwiftUIView.swift
//  
//
//  Created by Brayton Lordianto on 4/17/23.
//

import SwiftUI
import RealityKit

struct ChooseFrameARViewRepresentable: UIViewRepresentable {
    var arView = ARView()
    @Binding var frameIdx: Int
    func makeUIView(context: Context) -> ARView {
        initializeARView()
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        // when frame index changes, you want to set the ar view with the correct model
        let paintingFrameName = PaintingCollection.paintingFrameName(number: frameIdx)
        render(paintingModelName: paintingFrameName + ".usdz")
    }
}



struct ChooseFrameView: View {
    let image: UIImage
    @State private var frameIdx = 0
    @EnvironmentObject private var paintingCollection: PaintingCollection
    
    var body: some View {
        
        ZStack {
            // ar view
            ChooseFrameARViewRepresentable(frameIdx: $frameIdx)
                .ignoresSafeArea()
            
            // buttons on the side and bottom
            VStack {
                Spacer()
                HStack {
                    backButton()
                    Spacer()
                    nextButton()
                }
                Spacer()
                saveButton()
            }
        }
    }
    
    private func backButton() -> some View {
        Button {
            toggleIdxBackward()
        } label: {
            Image(systemName: "arrow.backward.circle")
                .resizable()
        }
        .buttonStyle(ChooseFrameButton())
    }
    private func nextButton() -> some View {
        Button {
            toggleIdxForward()
        } label: {
            Image(systemName: "arrow.forward.circle")
                .resizable()
        }
        .buttonStyle(ChooseFrameButton())
    }
    private func saveButton() -> some View {
        Button("Add Image With This Frame") {
            paintingCollection.addNewPainting(image: image, frameIndex: frameIdx)
        }
        .buttonStyle(.bordered)
        .tint(.blue)
        .padding()
        .foregroundColor(.green)
    }
    
    // implementations can change as more frames are added
    private func toggleIdxForward() { frameIdx = 1 - frameIdx }
    private func toggleIdxBackward() { frameIdx = 1 - frameIdx }
    
    private func saveImage() {
        paintingCollection.addNewPainting(image: image, frameIndex: frameIdx)
    }
}

struct ChooseFrameButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 50, height: 50)
            .padding(30)
            .foregroundColor(.teal)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

struct ChooseFrameView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseFrameView(image: UIImage())
            .environmentObject(PaintingCollection())
    }
}
