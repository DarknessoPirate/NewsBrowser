//
//  NewsResponse.swift
//  NewsBrowser
//
//  Created by RMS on 11/03/2025.
//


import Foundation

struct NewsResponse: Codable {
    let articles: [Article]
}

struct Article: Codable, Identifiable {
    let id = UUID()
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
}
