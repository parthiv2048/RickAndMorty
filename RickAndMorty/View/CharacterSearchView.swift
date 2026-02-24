//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Parthiv Ganguly on 2/23/26.
//

import SwiftUI

struct CharacterSearchView: View {
    
    // MARK: Properties

    private var characterSearchVM: CharacterSearchViewModelProtocol?
    @State private var searchQuery = ""
    
    init(characterSearchVM: CharacterSearchViewModelProtocol? = nil) {
        self.characterSearchVM = characterSearchVM
    }

    var body: some View {
        NavigationStack {
            List {
                if characterSearchVM?.getIsLoading() ?? false {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                } else if let errorMessage = characterSearchVM?.getErrorMessage() {
                    Text(errorMessage)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    ForEach(characterSearchVM?.getCharactersList() ?? []) { character in
                        NavigationLink(destination: CharacterDetailView(character: character)) {
                            CharacterRowView(character: character)
                        }
                    }
                }
            }
            .searchable(text: $searchQuery, placement: .navigationBarDrawer, prompt: "Search characters")
            .onChange(of: searchQuery) { _, newValue in
                characterSearchVM?.searchCharacter(query: newValue)
            }
        }
    }
}
