//
//  StorageManager.swift
//  FinalProject
//
//  Created by apple on 17.04.2024.
//

import Foundation

final class StorageManager {
    
    private let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    func saveImage(_ imgData: Data, imageName: String) {
        var path = url
        path.append(path: "\(imageName).jpg")
        do {
            try imgData.write(to: path)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadImage(_ fileName: String) -> Data? {
        var path = url
        path.append(path: "\(fileName).jpg")
        do {
            let img = try Data(contentsOf: path)
            return img
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func deleteImg(_ fileName: String) {
        let req = FileManager.default
        var path = url
        path.append(path: "\(fileName).jpg")
        do {
            try req.removeItem(at: path)
        } catch {
            print(error.localizedDescription)
        }
        
       
    }
    
}
