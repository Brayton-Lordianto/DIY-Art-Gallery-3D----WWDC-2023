//
//  File.swift
//  
//
//  Created by Brayton Lordianto on 4/17/23.
//

import Foundation
import UIKit
import RealityKit

class ImageFileLoader {
    private func fileName(imageName: String) -> String {
        imageName // you can optionally change the name here
    }
    
    private func imagePath(imageName: String) -> URL {
        let appFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let imagePath = appFilePath.appendingPathComponent(fileName(imageName: imageName))
        return imagePath
    }
    
    func saveImage(image: UIImage, imageName: String) {
        let data = image.jpegData(compressionQuality: 1)
        let imagePath = imagePath(imageName: imageName)
        
        print("saved image name is \(imageName)")
        do {
            try data?.write(to: imagePath)
        } catch {
            print("Error saving image")
        }
    }
    
    func loadImage(imageName: String) -> UIImage? {
        let imagePath = imagePath(imageName: imageName)
        let image = UIImage(contentsOfFile: imagePath.path)
        return image
    }
    
    func loadImageAsTexture(imageName: String) -> TextureResource? {
        do {
            print("image name is \(imageName)")
            let imagePath = imagePath(imageName: imageName)
            let imageAsTexture: TextureResource = try .load(contentsOf: imagePath)
            return imageAsTexture
        } catch {
            return nil
        }
    }
    
    func uploadToCameraRoll(imageName: String) {
        let uiimage = loadImage(imageName: imageName) ?? UIImage()
        UIImageWriteToSavedPhotosAlbum(uiimage, nil, nil, nil);
    }
}
