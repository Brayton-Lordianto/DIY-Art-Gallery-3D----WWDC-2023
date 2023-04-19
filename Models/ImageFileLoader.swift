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
    
    func saveImage(image: UIImage, imageName: String) {
        let data = image.jpegData(compressionQuality: 1)
        let appFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let imagePath = appFilePath.appendingPathComponent(fileName(imageName: imageName))
        
        do {
            try data?.write(to: imagePath)
        } catch {
            print("Error saving image")
        }
    }
    
    func loadImage(imageName: String) -> UIImage? {
        let appFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let imagePath = appFilePath.appendingPathComponent(fileName(imageName: imageName))
        let image = UIImage(contentsOfFile: imagePath.path)
        return image
    }
    
    func loadImageAsTexture(imageName: String) -> TextureResource? {
        do {
            let imageAsTexture: TextureResource = try .load(named: imageName)
            return imageAsTexture
        } catch {
            return nil
        }
    }
}
