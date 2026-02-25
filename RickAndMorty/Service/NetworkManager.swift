//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Parthiv Ganguly on 2/24/26.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchCharacters(url: String) async -> NetworkState
}

class NetworkManager: NetworkManagerProtocol {
    /// Use Singleton pattern to provide access to NetworkManager
    static let shared = NetworkManager()
    
    init() {}
    
    // MARK: - Fetch Characters from Server
    
    func fetchCharacters(url: String) async -> NetworkState {
        guard let serverURL = URL(string: url) else {
            return .invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: serverURL)
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                return .invalidServerResponse
            }
            let characterServerResponse = try? JSONDecoder().decode(CharacterServerResponse.self, from: data)
            return .success(characterServerResponse?.results ?? [])
        } catch {
            return .invalidData
        }
    }
}
