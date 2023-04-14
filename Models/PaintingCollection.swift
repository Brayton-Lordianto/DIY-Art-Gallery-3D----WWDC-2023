import Foundation
import UIKit

class PaintingCollection {
    // holds a bunch of objects
    private var paintingObjects: [PaintingModel]
    private static var paintingFrameChoices = ["rectangular-frame", "circular-frame"]
    
    // allows for text recognition of the images
    private var textRecognizer: VisionModel
    
    init() {
        self.paintingObjects = []
        self.textRecognizer = VisionModel()
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
    
    func changePaintingFrame(at index: Int, to frameIndex: Int) {
        paintingObjects[index].frameOption = frameIndex
    }    
}

