//
//  CharacterResponse.swift
//  RickAndMorty
//
//  Created by Parthiv Ganguly on 2/24/26.
//

import SwiftUI

struct Origin: Decodable {
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}

struct Character: Decodable, Identifiable {
    let id: Int?
    let name: String?
    let status: String?
    let species: String?
    let type: String?
    let origin: Origin?
    let image: String?
    let created: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case species
        case type
        case origin
        case image
        case created
    }
}

struct CharacterServerResponse: Decodable {
    let results: [Character]?
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}
