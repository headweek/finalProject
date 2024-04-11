//
//  ProfileViewModel.swift
//  FinalProject
//
//  Created by Salman Abdullayev on 11.04.24.
//

import UIKit

class ProfileViewModel {
    var user: User?
    var profileImage: UIImage?
    
    func loadProfileInfo(completion: @escaping () -> Void) {
        
        guard let accessToken = UserDefaults.standard.string(forKey: "access_token") else {
            return
        }
        
        let requestURL = "https://api.vk.com/method/users.get?fields=photo_100,first_name,last_name&access_token=\(accessToken)&v=5.199"

        URLSession.shared.dataTask(with: URL(string: requestURL)!) { [weak self] (data, response, error) in
            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(UserResponse.self, from: data)
                if let user = response.response.first {
                    self?.user = user
                    self?.loadProfileImage(completion: completion)
                }
            } catch let error {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }

    func loadProfileImage(completion: @escaping () -> Void) {
        guard let profileURLString = user?.photo100, let profileURL = URL(string: profileURLString) else {
            completion()
            return
        }

        URLSession.shared.dataTask(with: profileURL) { [weak self] (data, response, error) in
            guard let data = data else {
                completion()
                return
            }

            if let image = UIImage(data: data) {
                self?.profileImage = image
            }

            completion()
        }.resume()
    }
}


//vk1.a.Jli1vllnONnzB1cC1228Im262K2gCxCuR8_Q8KCNEVex1v38FvEnaX6dkGU-6wqWDvyGrftw4GxAx5PhtBKHUvzMTN1RKsSum4sBzbUi0o1piYX8i45olPfgU01oox99ihlg8bBf8kXZjo47SxnYlzXU5uPFfGikunHqs_LW7OQdkcIQez5Grq9jYZt382nS2ne3XD10c9jEeFlEomX5Gw
