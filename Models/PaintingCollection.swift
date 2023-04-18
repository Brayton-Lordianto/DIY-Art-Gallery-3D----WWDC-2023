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
    func addNewPainting(imageName: String, frameIndex: Int) {
        let defaultTitle = "Artwork \(count)"
        self.textRecognizer.setNewImage(imageName: imageName)
        let recognizedTitle = textRecognizer.readImageText() 
        self.paintingObjects.append(.init(imageName: imageName, frameOption: frameIndex, title: recognizedTitle ?? defaultTitle))
    }
    
    
    func addNewPainting(image: UIImage, frameIndex: Int) {
        print("painting about to be added")
        let defaultTitle = "Artwork \(count)"
        self.textRecognizer.setNewImage(image: image)
        let recognizedTitle = textRecognizer.readImageText()
        let title = recognizedTitle ?? defaultTitle
        let painting = PaintingModel(imageName: "\(title)\(count)", frameOption: frameIndex, title: title)
        paintingObjects = paintingObjects + [painting]
        imageFileLoader.saveImage(image: image, imageName: title)
        print("painting is added")
        print("\(paintingObjects)")
    }
    
    func changePaintingFrame(at index: Int, to frameIndex: Int) {
        paintingObjects[index].frameOption = frameIndex
    }    
}

