//
//  MainView.swift
//  BBQuotes
//
//  Created by Olivier Sbg on 07/09/2026.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            Tab(Constants.breakingBad, systemImage: "flask") {
                QuoteView(show: Constants.breakingBad)
            }
            
            Tab(Constants.betterCaulSaul, systemImage: "briefcase") {
                QuoteView(show: Constants.betterCaulSaul)
            }
            
            Tab(Constants.elCamino, systemImage: "car") {
                QuoteView(show: Constants.elCamino)
            }
            
        }.preferredColorScheme(.dark)
    }
}

#Preview {
    MainView()
}
