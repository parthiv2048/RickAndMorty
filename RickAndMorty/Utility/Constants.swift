//
//  Constants.swift
//  RickAndMorty
//
//  Created by Parthiv Ganguly on 2/24/26.
//

// MARK: - Server Endpoints

enum ServerEndpoints: String {
    case baseURL = "https://rickandmortyapi.com/api/character/?name="
}

// MARK: - Network State

enum NetworkState {
    case invalidURL
    case invalidServerResponse
    case invalidData
    case success([Character])
    
    var message: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidServerResponse:
            return "Server returned invalid response"
        case .invalidData:
            return "Error parsing data from server"
        case .success:
            return ""
        }
    }
}
