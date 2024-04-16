//
//  NewsData.swift
//  FinalProject
//
//  Created by apple on 07.04.2024.
//

import Foundation

struct NewsData : Decodable {
    let totalResults: Int
    let articles: [NewsArticles]
}

struct NewsArticles: Decodable {
    let source: NewsItem
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct NewsItem: Decodable {
    let id: String?
    let name: String?
}
