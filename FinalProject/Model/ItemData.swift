//
//  ItemData.swift
//  FinalProject
//
//  Created by apple on 07.04.2024.
//

import Foundation

struct ItemData: Decodable {
    let id: String
    let image: String
    let link: String?
    let date: String?
    let description: String?
    let title: String?
}
