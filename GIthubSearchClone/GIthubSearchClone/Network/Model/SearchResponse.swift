//
//  SearhResponse.swift
//  GIthubSearchClone
//
//  Created by 옥인준 on 2023/02/23.
//

import Foundation

struct SearchResponse: Codable {
    let totalCount: Int
    let items: [SearchDTO]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}

struct SearchDTO: Codable {
    /// Title
    let name: String
    /// Owner info
    let owner: OwnerDTO
    /// Description
    let description: String?
    /// Star Count
    let starCount: Int
    /// Language
    let language: String?
    
    enum CodingKeys: String, CodingKey {
        case name, owner, description, language
        case starCount = "stargazers_count"
    }
}

struct OwnerDTO: Codable {
    /// owner name
    let login: String
    /// owner image
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
}
