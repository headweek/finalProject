//
//  VKService.swift
//  FinalProject
//
//  Created by apple on 07.04.2024.
//

import Foundation

final class VKService {
    private init() {}
     
//            urlComponents.host = "api.vk.com"
//            urlComponents.path = "/method/\(path)"
//            
//            urlComponents.queryItems = [
//                URLQueryItem(name: "access_token", value: token),
//                URLQueryItem(name: "v", value: "5.199"),
//                URLQueryItem(name: "owner_id", value: publicId),
//                URLQueryItem(name: "count", value: "10"),

    
//    case baseUrl = "https://api.vk.com/method/"
//        case wall = "wall.get"
    
    static func getAuthRequest() -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        
        urlComponents.queryItems = [
        URLQueryItem(name: "client_id", value: "51892163"),
        URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
        URLQueryItem(name: "display", value: "mobile"),
        URLQueryItem(name: "response_type", value: "token"),
        URLQueryItem(name: "scope", value: "offline"),
        URLQueryItem(name: "v", value: "5.199"),
        ]
        
        guard let url = urlComponents.url else { return nil }
        
        let req = URLRequest(url: url)
        return req
    }
    
    static func getWallRequest() -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "dev.vk.com"
        urlComponents.path = "/ru/method/wall.get"
        
        urlComponents.queryItems = [
            URLQueryItem(name: .accessToken, value: "vk1.a.xVFhEvP23gmBYeiV30eBWj1CbQZtaYt45KAE6bIsRVO31Vc_rX2zeOHFK8lntjI0gDouSdHWLQcvgyK_SVMsbAMar0DBoHXcQmJ269BqvirCjgAcGt_SnmswN6NlLB3TvbhyB4vQu-B4yYVA5cjfV_z5hx8AmDudaELnFXq_dNhyYas5xMflUc12vk34c13PfX3Q8EDlyjpJzKknCi2Ykw"),
            URLQueryItem(name: "domain", value: "errornil"),
            URLQueryItem(name: "v", value: "5.199"),
            
        ]
        
        guard let url = urlComponents.url else { return nil }
        let req = URLRequest(url: url)
        return req
    }
    
    static func getWall(compltion: @escaping (Result<Welcome, Error>) -> ()) {
        
        guard let req = VKService.getWallRequest() else { return }
        
        URLSession.shared.dataTask(with: req) { data, _, error in
            guard error == nil else { compltion(.failure(error!)) ; return }
            guard let data else { return }
            
            if let decodeData = try? JSONDecoder().decode(Welcome.self, from: data) {
                print(decodeData)
                compltion(.success(decodeData))
            }
        }.resume()
    }
    
}
