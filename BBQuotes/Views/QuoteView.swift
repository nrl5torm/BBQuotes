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
    
    @State var isShowingCharacterInfo = false
    
    var body: some View {
        GeometryReader { gr in
            ZStack {
                Image(show.withoutCaseOrSpaces())
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
                            HStack(alignment: .top) {
                                Text("‟")
                                    .font(.system(size: 48))
                                    .padding(.leading)
                                
                                Text(vm.quote.quote)
                                    .minimumScaleFactor(0.5)
                                    .multilineTextAlignment(.center)
                                    .foregroundStyle(.white)
                                    .padding()
                                    .background(.black.opacity(0.5))
                                    .clipShape(.rect(cornerRadius:  25))
                                
                                Text("ˮ")
                                    .font(.system(size: 48))
                                    .padding(.trailing)
                            }
                            
                            ZStack(alignment: .bottom) {
                                AsyncImage(url: vm.character.images.randomElement()) { image in
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
                            .onTapGesture {
                                isShowingCharacterInfo.toggle()
                            }
                            
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
                            .foregroundStyle(Color("\(show.withoutSpaces())Primary"))
                            .padding()
                            .background(Color("\(show.withoutSpaces())Secondary"))
                            .clipShape(.rect(cornerRadius: 25))
                            .shadow(color: Color("\(show.withoutSpaces())Secondary"), radius: 10)
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
    QuoteView(
        show: Constants.breakingBad)
        .preferredColorScheme(.dark)
}
