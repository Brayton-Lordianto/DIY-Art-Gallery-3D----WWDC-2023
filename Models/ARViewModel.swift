import SwiftUI
import RealityKit

// handles all the state changes in the AR views
class AugmentedRealityViewModel: ObservableObject {
    @Published var arView: ARView
    var paintingCollection: PaintingCollection
    
    init() {
        arView = ARView()
        paintingCollection = PaintingCollection()
    }

    // returns a material with the image loaded into it
    private func getMaterial(imagePathname: String) -> SimpleMaterial {
        var material = SimpleMaterial()
        var imageAsTexture: TextureResource
        do {
            imageAsTexture = try .load(named: imagePathname, in: .main)
        } catch {
            print("Error attaching the image to the material")
            return material
        }
        
        let tintColor: UIColor = .white.withAlphaComponent(0.999)
        material.color = .init(tint: tintColor,
                               texture: .init(imageAsTexture))
        material.metallic = .float(1.0)
        material.roughness = .float(0.0)

        return material        
    }
    
    // load all models
    public func loadAllModels() {
        let anchor = AnchorEntity()

        // render each model in the painting collection
        for index in 0..<paintingCollection.count {
            // load the painting frame model
            let paintingFrameName = paintingCollection.paintingFrameName(at: index)
            let paintingFrameModel: ModelEntity
            do {
                paintingFrameModel = try ModelEntity.loadModel(named: paintingFrameName)
            } catch { print("Error loading painting frame model"); continue }
            
            // create a material and load the image into it
            let material = getMaterial(imagePathname: paintingCollection.imageName(at: index))

            // place the material texture onto the painting frame model
            // the materials of the model is such that the image is on the front of the frame
            paintingFrameModel.model?.materials[0] = material

            // add the model to the anchor
            anchor.addChild(paintingFrameModel)
        }

        // add the anchor to the ar view
        arView.scene.addAnchor(anchor)
    }
}
