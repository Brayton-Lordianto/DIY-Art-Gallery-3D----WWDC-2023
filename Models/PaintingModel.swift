import SwiftUI

// each painting an image, painting frame choice, and (optionally) coordinates
struct PaintingModel: Identifiable, Hashable {
    let id = UUID()
    let dateCreated = Date()
    var frameOption: Int
    var title: String
    var imageName: String {
        id.uuidString + Self.imgExtension
    }
    static let imgExtension = ".jpg"
}
