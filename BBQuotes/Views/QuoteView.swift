//
//  QuoteView.swift
//  BBQuotes
//
//  Created by Olivier Sbg on 17/09/2026.
//

import SwiftUI

struct QuoteView: View {
    let quote: Quote
    let character: Character
    let show: String
    let geometry: GeometryProxy
    
    @State var isShowingCharacterInfo = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if !character.images.isEmpty {
                AsyncImage(url: character.images.randomElement()) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                        .scaleEffect(6.0)
                }
                .frame(width: geometry.size.width * 0.85, height: geometry.size.height * 0.45)
                .onTapGesture {
                    isShowingCharacterInfo.toggle()
                }
                
            } else {
                Text("?")
                    .font(.system(size: 200))
                    .frame(width: geometry.size.width * 0.85, height: geometry.size.height * 0.45)
                    .background(.ultraThinMaterial)
            }
            
            Text(character.name)
                .foregroundStyle(.white)
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)
        }
        .frame(width: geometry.size.width * 0.85, height: geometry.size.height * 0.45)
        .clipShape(.rect(cornerRadius: 50))
        .padding(.bottom)
        
        HStack(alignment: .top) {
            Text("❝")
                .font(.system(size: 24))
                .padding(.leading)
            
            Text(quote.quote)
                .font(.headline)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
                .padding()
                .background(.black.opacity(0.6))
                .clipShape(.rect(cornerRadius:  25))
            
            Text("❞")
                .font(.system(size: 24))
                .padding(.trailing)
        }
        .sheet(isPresented: $isShowingCharacterInfo) {
            CharacterView(character: character, show: show)
        }
    }
}
