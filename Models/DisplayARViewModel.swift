//
//  File.swift
//  
//
//  Created by Brayton Lordianto on 4/17/23.
//

import Foundation
import RealityKit
import SwiftUI

class DisplayARViewModel {
//    var arView: Binding<ARView>?
//    
//    init(arView: Binding<ARView>? = nil) {
//        self.arView = arView
//    }
    
    static var arView = ARView()
    
    static func initializeARView() {
        print("hi")
//        arView.cameraMode = .nonAR
        arView.backgroundColor = .gray
    }
//    
    func render(paintingModelName: String) {
        // remove everything from the arView
        Self.arView.scene.anchors.removeAll()
        
        // load the new frame model into the ARview
        loadModel(modelName: paintingModelName)
    }
    
    private func loadModel(modelName: String) {
        // load the actual model
        var modelEntity: ModelEntity
        do {
            modelEntity = try ModelEntity.loadModel(named: modelName)
        } catch { print("unable to load model \(modelName)"); return }
        
        // add the model to an anchor and into the ar view
        let anchor = AnchorEntity()
        anchor.addChild(modelEntity)
        Self.arView.scene.addAnchor(anchor)
    }
}

// simply an ARView rendering whenever you change it?
// under each is a lazy var arview 
