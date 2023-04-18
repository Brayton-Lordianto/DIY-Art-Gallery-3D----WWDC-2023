import Foundation
import PencilKit

struct DrawingModel {
    var canvas: PKCanvasView
    var toolPicker: PKToolPicker
    
    init() {
        self.canvas = PKCanvasView()
        self.toolPicker = PKToolPicker()
     }
}

class DrawingViewModel: ObservableObject {
    @Published var drawingModel: DrawingModel
    
    init() {
        self.drawingModel = DrawingModel()
    }

    // initialize the canvas
    func initializeCanvas() {
        drawingModel.canvas.drawingPolicy = .anyInput
         drawingModel.canvas.backgroundColor = .clear
        
        // set up a built in tool picker 
         drawingModel.toolPicker.setVisible(true, forFirstResponder: drawingModel.canvas)
         drawingModel.toolPicker.addObserver(drawingModel.canvas)
         drawingModel.canvas.becomeFirstResponder()
    }
    
    //  return the drawing as a UIImage
    func drawingAsImage() -> UIImage {
        let drawing = drawingModel.canvas.drawing
        let image = drawing.image(from: drawing.bounds, scale: 1)
        return image
    }
    
//    func toolPickerSelectedToolDidChange(_ toolPicker: PKToolPicker) {
//        if let inkingTool = toolPicker.selectedTool as? PKInkingTool {
//            let color = inkingTool.color
//            drawingModel.canvas.tool = PKInkingTool(.pen, color: color, width: 10)
//        }
//    }
}
