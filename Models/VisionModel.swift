import UIKit
import Vision

// the purpose of any instance of this class is to take an image and output text 
class VisionModel {
    private var image: UIImage? {
        didSet { print("image in vision model changed ") }
    }
    private var text: String?
    private var imageFileLoader: ImageFileLoader
    
    init(imagePathname: String = "") {
        self.text = nil
        self.image = nil
        self.imageFileLoader = ImageFileLoader()
    }
    
    // load the image 
    private func loadImage(imageName: String) -> UIImage? {
        imageFileLoader.loadImage(imageName: imageName)
    }
    
    // the request we want to ask Vision; what to do with text that we can recognize 
    private func handleTextRecognition() -> VNRecognizeTextRequest {
        VNRecognizeTextRequest { (request, _) in
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            
            print("getting \(observations.count) observations for text")
            // start adding to the text
            self.text = ""
            for currentObservation in observations {
                let token = currentObservation.topCandidates(1)
                if let recognizedText = token.first {
                    self.text?.append(" " + recognizedText.string)
                }
            }
        }
    }
    
    // takes the text from the image 
    func readImageText() -> String? {
        guard let image,
              let ciImage = CIImage(image: image)
        else { return nil }

        // get the request we want to handle
        let request = handleTextRecognition()        
        
        // this will make our text recognition more accurate.
        request.recognitionLevel = .accurate
        
        // actually run the request on the given image, which is now accessible as a return value and a field in this instance
        let requestHandler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        do {
            try requestHandler.perform([request])
        } catch {
            text = nil
            print("failed to perform vision request on image")
        }
        
        print("found the text \(text)")
        
        return text
    }
    
    // utility - get the text or change the image
    func recognizedText() -> String? {
        text
    }
    
    func setNewImage(imageName: String) {
        self.image = loadImage(imageName: imageName)
    }
    
    func setNewImage(image: UIImage) {
        self.image = image
        print("updated the new image to be \(image)")
    }
}
