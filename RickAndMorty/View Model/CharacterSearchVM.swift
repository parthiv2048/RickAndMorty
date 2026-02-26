//
//  CharacterSearchViewModel.swift
//  RickAndMorty
//
//  Created by Parthiv Ganguly on 2/24/26.
//

import Combine

protocol CharacterSearchViewModelProtocol: ObservableObject {
    func searchCharacter(query: String)
    func getErrorMessage() -> String?
    func didFailToLoad() -> Bool
}

@MainActor
class CharacterSearchVM: CharacterSearchViewModelProtocol {
    
    // MARK: - Properties
    
    private var networkManager: NetworkManagerProtocol?
    @Published var networkState: NetworkState?
    
    // MARK: - Initializer
    
    init(networkManager: NetworkManagerProtocol? = nil) {
        self.networkManager = networkManager
    }
    
    // MARK: - Search Character using Network Manager

    func searchCharacter(query: String) {
        Task(priority: .high) {
            networkState = .loading
            networkState = await networkManager?.fetchCharacters(url: ServerEndpoints.baseURL.rawValue + query)
        }
    }
    
    // MARK: - Getter Methods
    
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
