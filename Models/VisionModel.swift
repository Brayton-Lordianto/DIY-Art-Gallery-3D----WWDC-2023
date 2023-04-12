import UIKit
import Vision

// the purpose of any instance of this class is to take an image and output text 
class VisionModel {
    private var image: UIImage?
    private var text: String
    init(imagePathname: String = "") {
        self.text = ""
        self.image = loadImage(imageName: imagePathname)
    }
    
    // load the image 
    private func loadImage(imageName: String) -> UIImage? {
        UIImage(named: imageName, in: .main, with: .none)
    }
    
    // the request we want to ask Vision; what to do with text that we can recognize 
    private func handleTextRecognition(errorMessage: String) -> VNRecognizeTextRequest {
        VNRecognizeTextRequest { (request, _) in
            self.text = ""
            guard let observations = request.results as? [VNRecognizedTextObservation] else { self.text = errorMessage; return }
            
            for currentObservation in observations {
                let token = currentObservation.topCandidates(1)
                if let recognizedText = token.first {
                    self.text += " " + recognizedText.string
                }
            }
        }
    }
    
    // takes the text from the image 
    public func readImageText() -> String {
        let errorMessage = "ERROR: Could Not Read Text\n"
        guard let image,
              let ciImage = CIImage(image: image)
        else { return errorMessage }

        // get the request we want to handle
        let request = handleTextRecognition(errorMessage: errorMessage)        
        
        // this will make our text recognition more accurate.
        request.recognitionLevel = .accurate
        
        // actually run the request on the given image, which is now accessible as a return value and a field in this instance
        let requestHandler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        do {
            try requestHandler.perform([request])
        } catch {
            text = errorMessage
        }
        
        return text
    }
    
    // utility - get the text or change the image
    public func getText() -> String {
        text
    }
    
    public func setNewImage(imageName: String) {
        self.image = loadImage(imageName: imageName)
    }
}
