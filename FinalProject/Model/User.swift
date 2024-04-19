//
//  User.swift
//  FinalProject
//
//  Created by Salman Abdullayev on 11.04.24.
//

import Foundation

struct User: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let photo100: String

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo100 = "photo_100"
    }
}

