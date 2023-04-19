//
//  File.swift
//  
//
//  Created by Brayton Lordianto on 4/18/23.
//

import Foundation
import Combine
import RealityKit
import UIKit

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
            })
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
        
        let tintColor: UIColor = .white
        material.color = .init(tint: tintColor,
                               texture: .init(imageAsTexture))
        material.metallic = .float(1.0)
        material.roughness = .float(0.0)
        
        return material
    }
    
    
}
