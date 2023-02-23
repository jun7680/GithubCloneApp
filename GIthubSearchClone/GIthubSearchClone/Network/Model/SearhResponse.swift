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
}

struct SearchDTO: Codable {
    let name: String
    let owner: OwnerDTO
    let description: String
    let starCount: Int
    let language: String
    
    enum CodingKeys: String, CodingKey {
        case name, owner, description, language
        case starCount = "stargazers_count"
    }
}

struct OwnerDTO: Codable {
    let login: String
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
}
