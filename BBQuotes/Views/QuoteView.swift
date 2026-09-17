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
    let geometry: GeometryProxy
    
    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: character.images.randomElement()) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
                    .scaleEffect(2.0)
            }
            .frame(width: geometry.size.width * 0.85, height: geometry.size.height * 0.5)
            
            Text(character.name)
                .foregroundStyle(.white)
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)
        }
        .frame(width: geometry.size.width * 0.85, height: geometry.size.height * 0.5)
        .clipShape(.rect(cornerRadius: 50))
        .padding(.bottom)
        
        HStack(alignment: .top) {
            Text("‟")
                .font(.system(size: 48))
                .padding(.leading)
            
            Text(quote.quote)
                .font(.headline)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
                .padding()
                .background(.black.opacity(0.6))
                .clipShape(.rect(cornerRadius:  25))
            
            Text("ˮ")
                .font(.system(size: 48))
                .padding(.trailing)
        }
    }
}
