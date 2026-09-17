//
//  ShowView.swift
//  BBQuotes
//
//  Created by Olivier Sbg on 10/09/2026.
//

import SwiftUI

struct ShowView: View {
    let vm = ViewModel()
    let show: String
    
    @State var isShowingCharacterInfo = false
    
    var body: some View {
        GeometryReader { g in
            ZStack {
                Image(show.withoutCaseOrSpaces())
                    .resizable()
                    .scaledToFill()
                    .frame(width: g.size.width, height: g.size.height)
                    
                VStack {
                    VStack {
                        Spacer(minLength: 80)
                        
                        switch vm.status {
                        case .notStarted:
                            EmptyView()
                            
                        case .fetching:
                            ProgressView()
                                .scaleEffect(4.0)
                            
                        case .quoteFetched:
                            QuoteView(quote: vm.quote, character: vm.character, geometry: g)
                            .onTapGesture {
                                isShowingCharacterInfo.toggle()
                            }
                            
                        case .episodeFetched:
                            EpisodeView(episode: vm.episode)

                        case .failed(let error):
                            Text(error.localizedDescription)
                                .padding()
                                .background(.black.opacity(0.5))
                                .clipShape(.rect(cornerRadius: 50))

                        }
                        
                        Spacer(minLength: 20)
                    }
                    
                    HStack {
                        Spacer()
                        
                        Button() {
                            Task {
                                await vm.getQuote(for: show)
                            }
                        } label: {
                            Text("Get Random Quote")
                                .font(.title2)
                                .bold()
                                .foregroundStyle(Color("\(show.withoutSpaces())Primary"))
                                .padding()
                                .background(Color("\(show.withoutSpaces())Secondary"))
                                .clipShape(.rect(cornerRadius: 25))
                                .shadow(color: Color("\(show.withoutSpaces())Secondary"), radius: 10)
                        }
                        
                        Spacer()
                        
                        Button() {
                            Task {
                                await vm.getEpisode(for: show)
                            }
                        } label: {
                            Text("Get Random Episode")
                                .font(.title2)
                                .bold()
                                .foregroundStyle(Color("\(show.withoutSpaces())Secondary"))
                                .padding()
                                .background(Color("\(show.withoutSpaces())Primary"))
                                .clipShape(.rect(cornerRadius: 25))
                                .shadow(color: Color("\(show.withoutSpaces())Primary"), radius: 10)
                        }
                        
                        Spacer()
                    }
                    
                    Spacer(minLength: 100)
                }
            }
        }
        .ignoresSafeArea()
        .sheet(isPresented: $isShowingCharacterInfo) {
            CharacterView(character: vm.character, show: show)
        }

    }
}

#Preview {
    ShowView(
        show: Constants.breakingBad)
        .preferredColorScheme(.dark)
}
