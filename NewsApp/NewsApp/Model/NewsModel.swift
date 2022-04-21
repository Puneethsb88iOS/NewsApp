//
//  NewsModel.swift
//  NewsApp
//
//  Created by Puneeth SB on 20/04/22.
//

import Foundation

struct NewsModel: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String
    let description: String
}

struct Source: Codable {
    let id: String?
    let name: String
}

