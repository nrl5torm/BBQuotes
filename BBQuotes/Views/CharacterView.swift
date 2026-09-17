//
//  CharacterView.swift
//  BBQuotes
//
//  Created by Olivier Sbg on 14/09/2026.
//

import SwiftUI
import Foundation

struct CharacterView: View {
    let character: Character
    let show: String
    
    @Namespace var infoStackId

    var body: some View {
        GeometryReader { g in
            ScrollViewReader { sv in
                
                ZStack(alignment: .top) {
                    Image(show.withoutCaseOrSpaces())
                        .resizable()
                        .scaledToFit()
                    
                    ScrollView() {
                        TabView{
                            ForEach(character.images, id: \.self) { imageUrl in
                                AsyncImage(url: imageUrl) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                        .scaleEffect(2.0)
                                }
                            }
                        }
                        .tabViewStyle(.page)
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
                            
                            DisclosureGroup("Status (spoiler alert):") {
                                VStack(alignment: .leading) {
                                    
                                    Text(character.status)
                                        .bold()
                                    
                                    if let death = character.death {
                                        AsyncImage(url: death.image) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .clipShape(.rect(cornerRadius: 15))
                                                .onAppear {
                                                    withAnimation {
                                                        sv.scrollTo(infoStackId, anchor: .bottom)
                                                    }
                                                }
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        
                                        Text("How:")
                                            .padding(.top)
                                        Text(death.details)
                                        
                                        Text("Last words:")
                                            .padding(.top)
                                        Text("\"\(death.lastWords)\"")
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(.top)
                            .tint(.primary)
                        }
                        .frame(width: g.size.width * 0.75, alignment: .leading)
                        .padding(.bottom, 50)
                        .id(infoStackId)
                    }
                    .scrollIndicators(.hidden)
                }
                .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    CharacterView(character: ViewModel().character,
                  show: Constants.breakingBad)
        .preferredColorScheme(.dark)

}
