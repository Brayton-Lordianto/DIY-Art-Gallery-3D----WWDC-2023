import Foundation
import UIKit
 
class PaintingCollection: ObservableObject {
    // holds a bunch of objects
    @Published var paintingObjects: [PaintingModel]
    private static var paintingFrameChoices = ["rectangular-frame", "circular-frame"]
    
    // allows for text recognition of the images
    private var textRecognizer: VisionModel
    
    private var imageFileLoader: ImageFileLoader
    
    init() {
        self.paintingObjects = []
        self.textRecognizer = VisionModel()
        self.imageFileLoader = ImageFileLoader()
    }
    
    // getters
    var count: Int {
        self.paintingObjects.count
    }
    
    func imageName(at index: Int) -> String {
        paintingObjects[index].imageName
    }
    
    // ======================
    
    // made static for accessibility from AR views when needed just the name 
    static func paintingFrameName(number: Int) -> String {
        Self.paintingFrameChoices[number]
    }
    
    
    func paintingFrameName(at index: Int) -> String {
        Self.paintingFrameName(number: paintingObjects[index].frameOption)
    }
    
    func title(at index: Int) -> String {
        paintingObjects[index].title
    }
    
    // MARK: setters and modifiers
    // adds a new painting and returns the title of the painting
    func addNewPainting(image: UIImage, frameIndex: Int) -> String {
        let defaultTitle = "Artwork \(count + 1)"
        let painting = PaintingModel(frameOption: frameIndex, title: defaultTitle)
        paintingObjects = paintingObjects + [painting]
        
        imageFileLoader.saveImage(image: image, imageName: painting.imageName)
        self.textRecognizer.setNewImage(imageName: painting.imageName)
        let recognizedTitle = textRecognizer.readImageText() ?? defaultTitle
        let title = recognizedTitle == "" ? defaultTitle : recognizedTitle
        
        return title
    }
    
    func changePaintingFrame(at index: Int, to frameIndex: Int) {
        paintingObjects[index].frameOption = frameIndex
    }
    
    func changePaintingName(at index: Int, to name: String) {
        paintingObjects[index].title = name
    }
    
}

