import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
//            CanvasView(drawingViewModel: DrawingViewModel())
//                .environmentObject(PaintingCollection())
            ChooseFrameView(image: UIImage())
                .environmentObject(PaintingCollection())
//            ZStack {
//                simplisticARViewRepresentable()
//            }

        }
    }
}




