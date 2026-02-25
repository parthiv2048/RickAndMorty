//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Parthiv Ganguly on 2/24/26.
//

import SwiftUI

struct CharacterDetailView: View {
    
    // MARK: - Properties

    let character: Character
    
    // MARK: - Character Detail View
    
    var characterDetailView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(character.name ?? "")
                .font(.largeTitle)
                .bold()
                .padding()
            
            AsyncImage(url: URL(string: character.image ?? "")) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Color.secondary.opacity(0.2)
                    .frame(height: 300)
            }
            .frame(maxWidth: .infinity)

            VStack(alignment: .leading, spacing: 8) {
                DetailRow(label: "Species", value: character.species ?? "")
                DetailRow(label: "Status", value: character.status ?? "")
                DetailRow(label: "Origin", value: character.origin?.name ?? "")
                
                if let characterType = character.type, !characterType.isEmpty {
                    DetailRow(label: "Type", value: characterType)
                }
                
                DetailRow(label: "Created", value: parseAndFormatDate(character.created ?? ""))
            }
            .padding(.horizontal)
        }
    }
    
    // MARK: - Body

    var body: some View {
        ScrollView {
            characterDetailView
        }
    }
}

// MARK: - Detail Row View

private struct DetailRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack(alignment: .top) {
            Text("\(label):")
                .fontWeight(.semibold)
                .frame(width: 80, alignment: .leading)
            Text(value)
                .foregroundStyle(.secondary)
        }
    }
}
