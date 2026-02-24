//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Parthiv Ganguly on 2/24/26.
//

import SwiftUI

protocol NetworkManagerProtocol {
    func fetchCharacters(url: String) async -> [Character]
}

class NetworkManager: NetworkManagerProtocol {
    /// Use Singleton pattern to provide access to NetworkManager
    static let shared = NetworkManager()
    
    init() {}
    
    // MARK: Fetch Characters from Server
    
    func fetchCharacters(url: String) async -> [Character] {
        guard let serverURL = URL(string: url) else {
            print("Log: Invalid URL")
            return []
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: serverURL)
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                print("Log: Server return error with code: \(httpResponse.statusCode)")
                return []
            }
            let characterServerResponse = try? JSONDecoder().decode(CharacterServerResponse.self, from: data)
            return characterServerResponse?.results ?? []
        } catch {
            print("Log: Error running Network code: \(error)")
            return []
        }
    }
}
