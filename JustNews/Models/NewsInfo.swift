//
//  NewsInfo.swift
//  JustNews
//

import Foundation

struct Post: Codable, Hashable {
    let id: Int
    let slug: String
    let url: String
    let title: String
    let content: String
    let image: String
    let thumbnail: String
    let status: String
    let category: String
    let publishedAt: String
    let updatedAt: String
    let userId: Int

    // Optional CodingKeys enum if you need to match specific JSON keys
    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case url
        case title
        case content
        case image
        case thumbnail
        case status
        case category
        case publishedAt
        case updatedAt
        case userId = "userId"
    }
}
