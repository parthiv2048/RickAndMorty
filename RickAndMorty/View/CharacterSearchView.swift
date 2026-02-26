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
    
    init(characterSearchVM: CharacterSearchVM) {
        self.characterSearchVM = characterSearchVM
    }
    
    // MARK: - Loading View
    
    var loadingView: some View {
        LazyHStack {
            Spacer()
            VStack {
                ProgressView()
                Text("Loading Data. Please wait...")
                    .font(.subheadline)
            }
            Spacer()
        }
    }
    
    // MARK: - Empty Results View
    
    var emptyResultsView: some View {
        Text("No Results")
            .font(.title)
            .foregroundStyle(.secondary)
    }
    
    // MARK: - Body
    
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
        .searchable(text: $searchQuery, placement: .navigationBarDrawer, prompt: "Search characters")
        .onChange(of: searchQuery) { _, newValue in
            characterSearchVM.searchCharacter(query: newValue)
        }
        // MARK: Error Alert
        .alert(characterSearchVM.getErrorMessage() ?? "",
               isPresented: .init(get: {characterSearchVM.didFailToLoad()}, set: {_ in}),
        ) {
            Button("Cancel") {}
            Button("Retry") {
                /// Retry button repeats the same search query
                characterSearchVM.searchCharacter(query: searchQuery)
            }
        }
    }
}

// MARK: - Character List View

struct characterListView: View {
    let characterList: [Character]
    
    var body: some View {
        List {
            ForEach(characterList) { character in
                NavigationLink(destination: CharacterDetailView(character: character)) {
                    CharacterRowView(character: character)
                }
            }
        }
    }
}
