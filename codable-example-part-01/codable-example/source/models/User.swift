//
//  User.swift
//  codable-example
//
//  Created by epac on 13/10/24.
//

struct User: Decodable {
    
    let id: Int
    let avatarUrl: String
    let name: String
    let login: String
    let email: String?
    let company: String?
    let location: String?
    let bio: String?
    let publicRepos: Int
    let followers: Int
    let following: Int
}
