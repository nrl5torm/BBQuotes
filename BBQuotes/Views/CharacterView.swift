//
//  CharacterView.swift
//  BBQuotes
//
//  Created by Olivier Sbg on 14/09/2026.
//

import SwiftUI

struct CharacterView: View {
    let character: Character
    let show: String

    var body: some View {
        GeometryReader { g in
            ZStack(alignment: .top) {
                Image(show.lowercased().replacingOccurrences(of: " ", with: ""))
                    .resizable()
                    .scaledToFit()
                
                ScrollView() {
                    AsyncImage(url: character.images[0]) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                            .scaleEffect(2.0)
                    }
                    .frame(width: g.size.width * 0.8, height: g.size.height * 0.6)
                    .clipShape(.rect(cornerRadius:  25))
                    .padding(.top, 60)
                    
                    
                    VStack(alignment: .leading) {
                        Text(character.name)
                            .font(.title)
                        
                        Text("Portrayed by \(character.portrayedBy)")
                            .font(.subheadline)

                        Divider()
                            .padding(.vertical, 5)

                        Text("Character Info")
                            .font(.title2)
                        
                        Text("Born: \(character.birthday)")
                        
                        Text("Occupations:")
                            .padding(.top)
                        
                        ForEach(character.occupations, id: \.self) { occupation in
                            Text("• \(occupation)")
                                .font(.subheadline)
                        }
                        
                        Text("Nicknames:")
                            .padding(.top)
                        
                        if character.aliases.isEmpty {
                            Text("None")
                                .font(.subheadline)
                        } else {
                            ForEach(character.aliases, id: \.self) { alias in
                                Text("• \(alias)")
                                    .font(.subheadline)
                            }
                        }
                        
                        Text(character.status)
                            .padding(.top)
                    }
                    .frame(width: g.size.width * 0.75, alignment: .leading)
                }
                .scrollIndicators(.hidden)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CharacterView(character: QuoteViewModel().character, show: "Breaking Bad")
        .preferredColorScheme(.dark)

}
