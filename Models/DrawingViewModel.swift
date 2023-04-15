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
    
    func toolPickerSelectedToolDidChange(_ toolPicker: PKToolPicker) {
        if let inkingTool = toolPicker.selectedTool as? PKInkingTool {
            let color = inkingTool.color
            drawingModel.canvas.
        }
    }
}
