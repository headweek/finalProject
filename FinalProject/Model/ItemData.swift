//
//  ItemData.swift
//  FinalProject
//
//  Created by apple on 07.04.2024.
//

import Foundation

struct ItemData: Decodable {
    let id: String
    let imageURL: String?
    let link: String?
    let date: String?
    let description: String?
    let title: String?
    let content: String?
    let author: String?
    var addStorage: Bool
}
