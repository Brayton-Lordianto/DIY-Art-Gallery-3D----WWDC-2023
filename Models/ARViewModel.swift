import SwiftUI
import RealityKit

// handles all the state changes in the AR views
class AugmentedRealityViewModel {
    //  
    var arView: ARView
    var paintingCollection: PaintingCollection
    
    init() {
        arView = ARView()
        paintingCollection = PaintingCollection()
    }
    
    // load all models
    public func loadAllModels() {
        
    }
    
    // load the image into a material
    private func getMaterial(imagePathname: String) -> SimpleMaterial? {
        var material = SimpleMaterial()
        var imageAsTexture: TextureResource
        do {
            imageAsTexture = try .load(named: imagePathname, in: .main)
        } catch {
            return nil 
        }
        
        let tintColor: UIColor = .white.withAlphaComponent(0.999)
        material.color = .init(tint: tintColor,
                               texture: .init(imageAsTexture))
        material.metallic = .float(1.0)
        material.roughness = .float(0.0)

        return material        
    }
}
