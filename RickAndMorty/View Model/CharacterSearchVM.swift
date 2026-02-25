//
//  CharacterSearchViewModel.swift
//  RickAndMorty
//
//  Created by Parthiv Ganguly on 2/24/26.
//

import Foundation

protocol CharacterSearchViewModelProtocol {
    func searchCharacter(query: String)
    func getNetworkState() -> NetworkState?
    func getErrorMessage() -> String?
    func didFailToLoad() -> Bool
}

@MainActor
@Observable
class CharacterSearchVM: CharacterSearchViewModelProtocol {
    
    // MARK: - Properties
    
    private var networkManager: NetworkManagerProtocol?
    private var networkState: NetworkState?
    
    // MARK: - Initializer
    
    init(networkManager: NetworkManagerProtocol? = nil, networkState: NetworkState? = .loading) {
        self.networkManager = networkManager
        self.networkState = networkState
    }
    
    // MARK: - Search Character using Network Manager

    func searchCharacter(query: String) {
        networkState = .loading
        Task(priority: .high) {
            networkState = await networkManager?.fetchCharacters(url: ServerEndpoints.baseURL.rawValue + query)
        }
    }
    
    // MARK: - Getter Methods
    
    func getNetworkState() -> NetworkState? {
        return networkState
    }
    
    func getErrorMessage() -> String? {
        switch networkState {
        case .failed(let networkError):
            return networkError.message
        default:
            return nil
        }
    }
    
    func didFailToLoad() -> Bool {
        switch networkState {
        case .failed(_):
            return true
        default:
            return false
        }
    }
}
