import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            PaintingsView()
                .environmentObject(PaintingCollection())
//            CanvasView(drawingViewModel: DrawingViewModel())
//                .environmentObject(PaintingCollection())
//            ChooseFrameView(image: UIImage())
//                .environmentObject(PaintingCollection())
//            ZStack {
//                simplisticARViewRepresentable()
//            }

        }
    }
}




