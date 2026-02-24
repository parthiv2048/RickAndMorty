//
//  CharacterRowView.swift
//  RickAndMorty
//
//  Created by Parthiv Ganguly on 2/24/26.
//

import SwiftUI

struct CharacterRowView: View {

    let character: Character

    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: character.image ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.secondary.opacity(0.2)
            }
            .frame(width: 60, height: 60)
            .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(character.name ?? "")
                    .font(.headline)
                Text(character.species ?? "")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}
