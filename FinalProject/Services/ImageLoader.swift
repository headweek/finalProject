//
//  ImageLoader.swift
//  FinalProject
//
//  Created by apple on 08.04.2024.
//

import UIKit

final class ImageLoader {
    private init() {}

    static var cashImages = NSCache<NSString, UIImage>()
    
    static func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        //Не работает Кэш. Никак не добавляет
        if let cashedImage = cashImages.object(forKey: url.absoluteString as NSString) {
            completion(cashedImage)
        } else {
            let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("Failed to load image:", error?.localizedDescription ?? "Unknown error")
                    completion(nil)
                    return
                }
                
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        completion(image)
                    } else {
                        completion(nil)
                    }
                }
            }.resume()

        }
        
    }
    
}
