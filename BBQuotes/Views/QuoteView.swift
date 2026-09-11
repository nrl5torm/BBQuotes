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
                    VStack {
                        Spacer(minLength: 70)
                        
                        switch vm.status {
                        case .notStarted:
                            EmptyView()
                            
                        case .fetching:
                            ProgressView()
                                .scaleEffect(4.0)
                            
                        case .success:
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
                                        .scaleEffect(2.0)
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
                            
                        case .failed(let error):
                            Text(error.localizedDescription)
                        }
                        
                        Spacer()
                    }
                    
                    Button() {
                        Task {
                            await vm.getData(for: show)
                        }
                    } label: {
                        Text("Get Random Quote")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(Color("\(show.replacingOccurrences(of: " ", with: ""))Primary"))
                            .padding()
                            .background(Color("\(show.replacingOccurrences(of: " ", with: ""))Secondary"))
                            .clipShape(.rect(cornerRadius: 25))
                            .shadow(color: Color("\(show.replacingOccurrences(of: " ", with: ""))Secondary"), radius: 10)
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
