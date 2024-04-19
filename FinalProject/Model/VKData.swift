//
//  VKData.swift
//  FinalProject
//
//  Created by apple on 08.04.2024.
//

import Foundation

struct Welcome: Decodable {
    let response: VKData
}

struct VKData: Decodable {
    let items: [VKItem]
}

struct VKItem: Decodable {
    let attachments: [VKAttachments]
    let id: Int
    let text: String
    let date: Int
}

struct VKAttachments: Decodable {
    let type: String
    let video: VKVideo?
    let photo: VKPhoto?
}

struct VKPhoto: Decodable {
    let sizes: [VKSizes]
    let text: String?
}

struct VKSizes: Decodable {
    let height: Int
    let width: Int
    let url: String
}


struct VKVideo: Decodable {
    let image: [VKImage]
    let title: String?
}

struct VKImage: Decodable {
    let url: String
    let width: Int
    let height: Int
}
