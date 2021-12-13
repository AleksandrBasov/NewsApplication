//
//  News.swift
//  News
//
//  Created by Александр Басов on 12/5/21.
//

import Foundation

struct Result: Codable {
    var status: String
    var totalResults: Int
    var articles: [Article]
}

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}

struct Source: Codable {
    let id: String?
    let name: String?
    let category: String?
}
