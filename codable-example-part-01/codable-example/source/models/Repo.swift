//
//  Repo.swift
//  codable-example
//
//  Created by epac on 13/10/24.
//

struct Repo: Decodable {

    let id: Int
    let name: String
    let description: String?
    let htmlUrl: String
    let `private`: Bool
}
