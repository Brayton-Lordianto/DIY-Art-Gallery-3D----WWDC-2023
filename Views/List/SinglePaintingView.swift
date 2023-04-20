//
//  SwiftUIView.swift
//  
//
//  Created by Brayton Lordianto on 4/18/23.
//

import SwiftUI

struct SinglePaintingView: View {
    let painting: PaintingModel
    let imageFileLoader = ImageFileLoader()
    var body: some View {
        VStack {
            Text(painting.title)
            
            Image(uiImage: imageFileLoader.loadImage(imageName: painting.imageName) ?? UIImage())
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .cornerRadius(10)
            
            Button("Save Image") {
                imageFileLoader.uploadToCameraRoll(imageName: painting.imageName)
            }
            .buttonStyle(.bordered)
            
            Text("Created at: \(painting.dateCreated)")
            
        }
    }
}

struct SinglePaintingView_Previews: PreviewProvider {
    static var previews: some View {
        SinglePaintingView(painting: PaintingModel(frameOption: 1, title: "Artwork 1"))
    }
}
