//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Parthiv Ganguly on 2/24/26.
//

import SwiftUI

struct CharacterDetailView: View {

    let character: Character
    
    // MARK: Parse and Format Date of character.created
    
    private func parseAndFormatDate(_ dateString: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let date = isoFormatter.date(from: dateString) else {
            return "Invalid date"
        }
        
        let readableFormatter = DateFormatter()
        readableFormatter.dateFormat = "MMMM d, yyyy 'at' h:mm a"
        readableFormatter.timeZone = TimeZone.current
        
        return readableFormatter.string(from: date)
    }

    var body: some View {
        ScrollView {
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
    }
}

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
