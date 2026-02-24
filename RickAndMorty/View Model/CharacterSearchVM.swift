//
//  CharacterSearchViewModel.swift
//  RickAndMorty
//
//  Created by Parthiv Ganguly on 2/24/26.
//

import SwiftUI

protocol CharacterSearchViewModelProtocol {
    func searchCharacter(query: String)
    func getIsLoading() -> Bool?
    func getErrorMessage() -> String?
    func getCharactersList() -> [Character]?
}

@Observable
class CharacterSearchVM: CharacterSearchViewModelProtocol {

    private var networkManager: NetworkManagerProtocol?
    private var charactersList: [Character]?
    private var isLoading: Bool?
    private var errorMessage: String?
    
    init(networkManager: NetworkManagerProtocol? = nil, charactersList: [Character]? = nil, isLoading: Bool? = nil, errorMessage: String? = nil) {
        self.networkManager = networkManager
        self.charactersList = charactersList
        self.isLoading = isLoading
        self.errorMessage = errorMessage
    }

    func searchCharacter(query: String) {
        Task {
            isLoading = true
            errorMessage = nil
            charactersList = await networkManager?.fetchCharacters(url: ServerEndpoints.baseURL.rawValue + query)
            if let uwCharactersList = charactersList, uwCharactersList.isEmpty {
                errorMessage = "No results for '\(query)'"
            }
            isLoading = false
        }
    }
    
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
