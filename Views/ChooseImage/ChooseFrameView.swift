//
//  SwiftUIView.swift
//  
//
//  Created by Brayton Lordianto on 4/17/23.
//

import SwiftUI
import RealityKit

struct chooseFrameARView: UIViewRepresentable {
    // have an observed object
    @ObservedObject var displayARViewModel: DisplayARViewModel
    func makeUIView(context: Context) -> ARView {
        let ar = ARView()
        return ar
//        displayARViewModel.initializeARView()
//        return displayARViewModel.arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        // do nothing
    }
}

struct simplisticARViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let ar = ARView()
        ar.cameraMode = .nonAR
        ar.environment.background = .color(.gray)
        // load the actual model
        var modelEntity: ModelEntity
        do {
            modelEntity = try ModelEntity.loadModel(named: "circular-frame.usdz")
            modelEntity.generateCollisionShapes(recursive: true)
            ar.installGestures([.scale, .rotation], for: modelEntity)
        } catch { return ar }
        
        // add the model to an anchor and into the ar view
        let anchor = AnchorEntity()
        anchor.addChild(modelEntity)
        ar.scene.addAnchor(anchor)

        return ar
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        // do nothing
    }
}



struct ChooseFrameView: View {
    let image: UIImage
    @State private var frameIdx = 0
    @EnvironmentObject private var paintingCollection: PaintingCollection
//    @StateObject private var displayARViewModel = DisplayARViewModel()
    
    var body: some View {
        
        ZStack {
            // ar view
//            chooseFrameARView(displayARViewModel: displayARViewModel)
            simplisticARViewRepresentable()
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
        .onAppear {
            
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
        Button("Use This Frame") {

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
    }
}

struct ChooseFrameView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseFrameView(image: UIImage())
            .environmentObject(PaintingCollection())
    }
}
