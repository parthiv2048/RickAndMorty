//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Parthiv Ganguly on 2/23/26.
//

import SwiftUI

struct CharacterSearchView: View {
    
    // MARK: - Properties

    private var characterSearchVM: CharacterSearchViewModelProtocol?
    @State private var searchQuery = ""
    
    init(characterSearchVM: CharacterSearchViewModelProtocol? = nil) {
        self.characterSearchVM = characterSearchVM
    }
    
    // MARK: - Character List View
    
    var characterListView: some View {
        List {
            if characterSearchVM?.getIsLoading() ?? false {
                HStack {
                    Spacer()
                    VStack {
                        ProgressView()
                        Text("Loading Data, Please Wait...")
                    }
                    Spacer()
                }
            } else {
                ForEach(characterSearchVM?.getCharactersList() ?? []) { character in
                    NavigationLink(destination: CharacterDetailView(character: character)) {
                        CharacterRowView(character: character)
                    }
                }
            }
        }
        .alert(
            characterSearchVM?.getErrorMessage() ?? "",
            isPresented: .init(get: {characterSearchVM?.getErrorMessage() != nil}, set: {_ in})
        )
        {
            Button("Cancel") {}
            Button("Retry") {
                characterSearchVM?.searchCharacter(query: searchQuery)
            }
        }
        .searchable(text: $searchQuery, placement: .navigationBarDrawer, prompt: "Search characters")
        .onChange(of: searchQuery) { _, newValue in
            characterSearchVM?.searchCharacter(query: newValue)
        }
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            characterListView
        }
    }
}
