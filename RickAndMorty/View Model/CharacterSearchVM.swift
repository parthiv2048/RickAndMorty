//
//  CharacterSearchViewModel.swift
//  RickAndMorty
//
//  Created by Parthiv Ganguly on 2/24/26.
//

import Foundation

protocol CharacterSearchViewModelProtocol {
    func searchCharacter(query: String)
    func getIsLoading() -> Bool?
    func getErrorMessage() -> String?
    func getCharactersList() -> [Character]?
}

@Observable
class CharacterSearchVM: CharacterSearchViewModelProtocol {
    
    // MARK: - Properties
    
    private var networkManager: NetworkManagerProtocol?
    private var charactersList: [Character]?
    private var isLoading: Bool?
    private var errorMessage: String?
    
    // MARK: - Initializer
    
    init(networkManager: NetworkManagerProtocol? = nil, charactersList: [Character]? = nil, isLoading: Bool? = nil, errorMessage: String? = nil) {
        self.networkManager = networkManager
        self.charactersList = charactersList
        self.isLoading = isLoading
        self.errorMessage = errorMessage
    }
    
    // MARK: - Search Character using Network Manager

    func searchCharacter(query: String) {
        Task {
            isLoading = true
            errorMessage = nil
            
            guard let networkState: NetworkState = await networkManager?.fetchCharacters(url: ServerEndpoints.baseURL.rawValue + query) else {
                return
            }
            
            switch networkState {
            case .invalidURL, .invalidData, .invalidServerResponse:
                errorMessage = networkState.message
            case .success(let characters):
                self.charactersList = characters
            }
            
            if let uwCharactersList = charactersList, uwCharactersList.isEmpty {
                errorMessage = "No results for '\(query)'"
            }
            isLoading = false
        }
    }
    
    // MARK: - Getter Methods
    
    func getIsLoading() -> Bool? {
        return isLoading
    }
    
    func getErrorMessage() -> String? {
        return errorMessage
    }
    
    func getCharactersList() -> [Character]? {
        return charactersList
    }
}
