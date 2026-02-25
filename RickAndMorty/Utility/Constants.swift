//
//  Constants.swift
//  RickAndMorty
//
//  Created by Parthiv Ganguly on 2/24/26.
//

import Foundation

// MARK: - Server Endpoints

enum ServerEndpoints: String {
    case baseURL = "https://rickandmortyapi.com/api/character/?name="
}

// MARK: - Network State

enum NetworkState {
    case loading
    case failed(NetworkError)
    case empty
    case success([Character])
}

// MARK: - Network Error

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case dataParsingError
    case invalidServerResponse
    case networkConnectionError
    
    var message: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidServerResponse:
            return "Server returned invalid response"
        case .dataParsingError:
            return "Error parsing data from server"
        case .networkConnectionError:
            return "Problem with network connection"
        }
    }
}
