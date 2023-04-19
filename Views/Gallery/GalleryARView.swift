//
//  SwiftUIView.swift
//  
//
//  Created by Brayton Lordianto on 4/18/23.
//

import SwiftUI
import RealityKit
import Combine // since we are loading multiple models, doing so asynchronously is best

// will load all the images and place it into the corresponding 3D frame, all asynchrnously
struct GalleryARViewRepresentable: UIViewRepresentable {
    @ObservedObject var paintingCollection: PaintingCollection
    var imageFileLoader = ImageFileLoader()
    var arView = ARView()
    var objectsAnchor = AnchorEntity()
    
    func makeUIView(context: Context) -> ARView {
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

extension GalleryARViewRepresentable {
    // Place Single Model
    func placeAsynchronously(painting: PaintingModel, at location: SIMD3<Float>) {
        var cancellable: Cancellable? = nil
        
        // load the model asynchronously
        let paintingFrameModelName = PaintingCollection.paintingFrameName(number: painting.frameOption)
        
        cancellable = Entity.loadModelAsync(named: paintingFrameModelName)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Unable to load a model due to error \(error)")
                }
                cancellable?.cancel()
                
            }, receiveValue: { [self] (model: Entity) in
                guard let modelEntity = model as? ModelEntity else { print("unalbe to get \(painting.title) as model entity."); return }
                render(imageName: painting.imageName, onto: modelEntity)
                
//
//                if let model = model as? ModelEntity {
//                    self.model = model
//                    cancellable?.cancel()
//                    print("Model \(painting.title) is successfully loaded")
//
////                    anchor.position = [0.4, 1.5, -1]
////                    anchor.scale = [300, 300, 300]   // set appropriate scale
////                    arView.scene.anchors.append(anchor)
//                }
            })

        
//        cancellable = ModelEntity.loadAsync(named: paintingFrameModelName).sink { _ in
//            cancellable?.cancel()
//        } receiveValue: { entity in
//            guard let modelEntity = entity as? ModelEntity else { print("unalbe to get \(painting.title) as model entity."); return }
//            render(imageName: painting.imageName, onto: modelEntity)
//        }
    }
    
    // render image on top of the entity
    private func render(imageName: String, onto modelEntity: ModelEntity) {
        // create a material and load the image into it
        let material = getMaterial(imagePathname: imageName)

        // place the material texture onto the painting frame model
        // the materials of the model is such that the image is on the front of the frame
        modelEntity.model?.materials[0] = material

        // add the model to the anchor
        objectsAnchor.addChild(modelEntity)
    }
    
    // returns a material with the image loaded into it
    private func getMaterial(imagePathname: String) -> SimpleMaterial {
        var material = SimpleMaterial()
        guard let imageAsTexture = imageFileLoader.loadImageAsTexture(imageName: imagePathname) else {
            print("Error attaching the image to the material")
            return material
        }

        let tintColor: UIColor = .white.withAlphaComponent(1)
        material.color = .init(tint: tintColor,
                               texture: .init(imageAsTexture))
        material.metallic = .float(1.0)
        material.roughness = .float(0.0)

        return material
    }


}
