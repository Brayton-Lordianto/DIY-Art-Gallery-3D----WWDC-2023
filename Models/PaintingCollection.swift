import Foundation
import UIKit

class PaintingCollection {
    // holds a bunch of objects, each of which having an image, painting frame choice, and (optionally) coordinates
    private var objectCount: Int // bookeeping
    private var images: [String]
    private var frames: [Int]
    private static var paintingFrameChoices = ["rectangular-frame", "circular-frame"]
    
    // allows for text recognition of the images
    private var textRecognizer: VisionModel
    private var recognizedTitles: [String]
    
    init() {
        self.objectCount = 0
        self.images = []
        self.frames = []
        self.recognizedTitles = []
        self.textRecognizer = VisionModel()
    }
    
    // getters
    var count: Int {
        objectCount
    }
    
    func imageName(at index: Int) -> String {
        images[index]
    }
    
    func paintingFrameName(at index: Int) -> String {
        Self.paintingFrameChoices[frames[index]]
    }
    
    func title(at index: Int) -> String {
        recognizedTitles[index]
    }
    
    // setters and modifiers
    func addNewPainting(imageName: String, frameIndex: Int) {
        self.objectCount += 1
        self.images.append(imageName)
        self.frames.append(frameIndex)
        self.textRecognizer.setNewImage(imageName: images.last!)
        let recognizedTitle = textRecognizer.readImageText()
        // do some error checking here
        self.recognizedTitles.append(recognizedTitle)
    }
    
    func changePaintingFrame(at index: Int, to frameIndex: Int) {
        frames[index] = frameIndex
    }    
}
