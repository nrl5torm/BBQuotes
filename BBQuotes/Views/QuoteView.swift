//
//  QuoteView.swift
//  BBQuotes
//
//  Created by Olivier Sbg on 10/09/2026.
//

import SwiftUI

struct QuoteView: View {
    let vm = QuoteViewModel()
    let show: String
    
    var body: some View {
        GeometryReader { gr in
            ZStack {
                Image(show.lowercased().replacingOccurrences(of: " ", with: ""))
                    .resizable()
                    .scaledToFill()
                    .frame(width: gr.size.width, height: gr.size.height)
                    
                VStack {
                    Text("\"\(vm.quote.quote)\"")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .padding()
                        .background(.black.opacity(0.5))
                        .clipShape(.rect(cornerRadius:  25))
                        .padding(.horizontal)
                    
                    ZStack(alignment: .bottom) {
                        AsyncImage(url: vm.character.images[0]) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: gr.size.width * 0.9, height: gr.size.height * 0.55)

                        Text(vm.character.name)
                            .foregroundStyle(.white)
                            .padding(10)
                            .frame(maxWidth: .infinity)
                            .background(.ultraThinMaterial)
                    }
                    .frame(width: gr.size.width * 0.9, height: gr.size.height * 0.55)
                    .clipShape(.rect(cornerRadius: 50))

                }
            }
        }
        .ignoresSafeArea()

    }
}

#Preview {
    QuoteView(show: "Breaking Bad")
        .preferredColorScheme(.dark)
}
