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
    
    func paintingFrameName(at index: Int) -> String {
        Self.paintingFrameChoices[paintingObjects[index].frameOption]
    }
    
    func title(at index: Int) -> String {
        paintingObjects[index].title
    }
    
    // setters and modifiers
    func addNewPainting(imageName: String, frameIndex: Int) {
        let defaultTitle = "Artwork \(count)"
        self.textRecognizer.setNewImage(imageName: imageName)
        let recognizedTitle = textRecognizer.readImageText() 
        self.paintingObjects.append(.init(imageName: imageName, frameOption: frameIndex, title: recognizedTitle ?? defaultTitle))
    }
    
    
    func addNewPainting(image: UIImage, frameIndex: Int) {
        let defaultTitle = "Artwork \(count)"
        self.textRecognizer.setNewImage(image: image)
        let recognizedTitle = textRecognizer.readImageText()
        let title = recognizedTitle ?? defaultTitle
        self.paintingObjects.append(.init(imageName: "", frameOption: frameIndex, title: title))
        imageFileLoader.saveImage(image: image, imageName: title)
    }
    
    func changePaintingFrame(at index: Int, to frameIndex: Int) {
        paintingObjects[index].frameOption = frameIndex
    }    
}

