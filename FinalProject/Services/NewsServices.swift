//
//  NewsServices.swift
//  FinalProject
//
//  Created by apple on 07.04.2024.
//

import Foundation

final class NewsServices {
    
    private init () {}
    
      
    static func getNews(q: String, pageSize: Int = 10, complition: @escaping (Result<NewsData, Error>) -> ()) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "newsapi.org"
        urlComponents.path = "/v2/everything"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: q),
            URLQueryItem(name: "pageSize", value: "\(pageSize)"),
            URLQueryItem(name: "apiKey", value: "1acd7c2a00d648468b9f0c78f10aa637"),
            URLQueryItem(name: "language", value: "ru")
        ]
        
        guard let url = urlComponents.url else { return }
        
        let req = URLRequest(url: url)
        
        
        URLSession.shared.dataTask(with: req) { data, _, error in
            guard error == nil else { complition(.failure(error!)) ; return }
            guard let data else { return }
            
            if let decodeData = try? JSONDecoder().decode(NewsData.self, from: data) {
                print(decodeData)
                complition(.success(decodeData))
            }
        }.resume()
        
    }

    
}
