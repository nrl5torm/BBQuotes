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
                    Spacer(minLength: 70)
                    
                    Text(vm.quote.quote)
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .padding()
                        .background(.black.opacity(0.5))
                        .clipShape(.rect(cornerRadius:  25))
                        .padding(.horizontal)
                    
                    ZStack(alignment: .bottom) {
                        // TODO randomly select any of the available images
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

                    Spacer()
                    
                    Button() {
                        Task {
                            await vm.getData(for: show)
                        }
                    } label: {
                        Text("Get Random Quote")
                            .font(.title2)
                            .foregroundStyle(.white)
                            .padding()
                            .background(.breakingBadGreen)
                            .clipShape(.rect(cornerRadius: 25))
                            .shadow(color: .breakingBadYellow, radius: 10)
                    }
                    
                    Spacer(minLength: 100)
                }
            }
        }
        .ignoresSafeArea()

    }
}

#Preview {
    QuoteView(
        show: "Breaking Bad")
//        show: "Better Call Saul")
        .preferredColorScheme(.dark)
}
