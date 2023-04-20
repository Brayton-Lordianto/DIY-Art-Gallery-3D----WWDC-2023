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
    @Binding var image: UIImage
    @State private var frameIdx = 0
    @EnvironmentObject private var paintingCollection: PaintingCollection
    @State private var showingAlert = false
    @State private var paintingTitle = ""
    
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
            .alert("Name Your Beautiful Artwork", isPresented: $showingAlert, actions: {
                TextField("Name is being scanned...", text: $paintingTitle)
                alertSaveButton()
                Button("Cancel", role: .destructive) {}
            }, message: {
                VStack {
                    Text("If your artwork contains text, it will show up here.")
                }
            })
        }
    }
    
    private func alertSaveButton() -> some View {
        Button("Save", role: .cancel) {
            guard paintingCollection.count != 0 else { return }
            paintingCollection.changePaintingName(at: paintingCollection.count - 1, to: paintingTitle)
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
            paintingTitle = paintingCollection.addNewPainting(image: image, frameIndex: frameIdx)
            showingAlert.toggle()
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
        showingAlert.toggle()
        paintingTitle = paintingCollection.addNewPainting(image: image, frameIndex: frameIdx)
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
        ChooseFrameView(image: .constant(UIImage()))
            .environmentObject(PaintingCollection())
    }
}
