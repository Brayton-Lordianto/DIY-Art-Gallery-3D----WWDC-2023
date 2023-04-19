//
//  SwiftUIView.swift
//  
//
//  Created by Brayton Lordianto on 4/18/23.
//

import SwiftUI
import RealityKit

// on appear, set up the ar view representable.
// when disappear, set it to nil 
struct GalleryView: View {
    @State private var arViewRepresentable: GalleryARViewRepresentable? = nil
    @EnvironmentObject var paintingCollection: PaintingCollection 
    var body: some View {
        arViewRepresentable
    }
    
    func initializeAR() {
        arViewRepresentable = GalleryARViewRepresentable(paintingCollection: paintingCollection)
    }
    
    func uninitializeAR() {
        arViewRepresentable = nil
    }
}

// will load all the images and place it into the corresponding 3D frame, all asynchrnously
struct GalleryARViewRepresentable: UIViewRepresentable {
    @ObservedObject var paintingCollection: PaintingCollection
    var imageFileLoader = ImageFileLoader()
    var arView = ARView()
    var objectsAnchor = AnchorEntity()
    
    func makeUIView(context: Context) -> ARView {
        appeared()
        return arView
    }
    
    func appeared() {
        // load all the models asynchronously
        for index in 0..<paintingCollection.count {
            placeAsynchronously(painting: paintingCollection.paintingObjects[index], at: SIMD3<Float>(x: 0, y: 0, z: 0))
        }
        
        arView.scene.anchors.append(objectsAnchor)
    }
    
    
    func updateUIView(_ uiView: ARView, context: Context) {
        // do nothing
    }
}
