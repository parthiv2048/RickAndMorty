//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Parthiv Ganguly on 2/23/26.
//

import SwiftUI

struct CharacterSearchView: View {
    
    // MARK: - Properties

    @ObservedObject private var characterSearchVM: CharacterSearchVM
    @State private var searchQuery = ""
    
    // MARK: - Initializer (View Model Injected)
    
    init(characterSearchVM: CharacterSearchVM) {
        self.characterSearchVM = characterSearchVM
    }
    
    // MARK: - Loading View
    
    var loadingView: some View {
        LazyHStack {
            Spacer()
            VStack {
                ProgressView()
                Text(StringConstants.loadingText.rawValue)
                    .font(.subheadline)
            }
            Spacer()
        }
    }
    
    // MARK: - Empty Results View
    
    var emptyResultsView: some View {
        Text(StringConstants.emptyResults.rawValue)
            .font(.title)
            .foregroundStyle(.secondary)
    }
    
    // MARK: - Body View
    
    var body: some View {
        NavigationView {
            switch characterSearchVM.networkState {
            case .loading:
                loadingView
            case .success(let characterList):
                characterListView(characterList: characterList)
            default:
                emptyResultsView
            }
        }
        // MARK: Search Bar
        .searchable(text: $searchQuery, placement: .navigationBarDrawer, prompt: StringConstants.searchPrompt.rawValue)
        .onChange(of: searchQuery) { _, newValue in
            characterSearchVM.searchCharacter(query: newValue)
        }
        // MARK: Error Alert
        .alert(characterSearchVM.getErrorMessage() ?? "",
               isPresented: .init(get: {characterSearchVM.didFailToLoad()}, set: {_ in}),
        ) {
            Button("Cancel") {}
                .accessibilityLabel("Cancel the search")
            
            Button("Retry") {
                /// Retry button repeats the same search query
                characterSearchVM.searchCharacter(query: searchQuery)
            }
            .accessibilityLabel("Retry the search with the same query")
        }
    }
}

// MARK: - Character List View

struct characterListView: View {
    let characterList: [Character]
    
    var body: some View {
        List {
            ForEach(characterList) { character in
                let characterName = character.name ?? ""
                /// Use array of character name parts for voice-control labels
                /// For example - "Abadango Cluster Princess" will become ["Abadango Cluster Princess" , "Abadango", "Cluster", "Princess"]
                let characterNamesSplit: [Substring] = [Substring(characterName)] + characterName.split(separator: " ")
                NavigationLink(destination: CharacterDetailView(character: character)) {
                    CharacterRowView(character: character)
                }
                .accessibilityLabel("Tap to learn more about \(characterName)")
                .accessibilityInputLabels(characterNamesSplit)
            }
        }
    }
}
