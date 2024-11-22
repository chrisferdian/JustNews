//
//  APIRouter.swift
//  JustNews
//
//  Created by Indo Teknologi Utama on 14/11/24.
//

enum APIRouter {
    static let baseURL = "https://jsonplaceholder.org/"
    case posts
    
    var path: String {
        switch self {
        case .posts:
            return "posts"
        }
    }
    
    var parameters: [String: Any?]? {
        return nil
    }
}
