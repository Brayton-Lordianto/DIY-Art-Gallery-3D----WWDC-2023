//
//  SwiftUIView.swift
//  
//
//  Created by Brayton Lordianto on 4/18/23.
//

import SwiftUI
import RealityKit

// will load all the images and place it into the corresponding 3D frame, all asynchrnously
struct GalleryARViewRepresentable: UIViewRepresentable {
    @ObservedObject var paintingCollection: PaintingCollection
    var imageFileLoader = ImageFileLoader()
    var arView = ARView()
    var objectsAnchor = AnchorEntity()
    
    let translationUnit: Float = 0.3
    
    func makeUIView(context: Context) -> ARView {
        appeared()
        return arView
    }
    
    func appeared() {
        // load all the models asynchronously
        for index in 0..<paintingCollection.count {
            placeAsynchronously(painting: paintingCollection.paintingObjects[index], index: index)
        }
        
        arView.scene.anchors.append(objectsAnchor)
    }
    
    
    func updateUIView(_ uiView: ARView, context: Context) {
        // do nothing
    }
}
