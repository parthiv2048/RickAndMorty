//
//  RickAndMortyApp.swift
//  RickAndMorty
//
//  Created by Parthiv Ganguly on 2/23/26.
//

import SwiftUI

@main
struct RickAndMortyApp: App {
    
    @StateObject private var characterSearchVM = CharacterSearchVM(networkManager: NetworkManager.shared)
    
    var body: some Scene {
        WindowGroup {
            CharacterSearchView(characterSearchVM: characterSearchVM)
        }
    }
}
