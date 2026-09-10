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
            Tab("Breaking Bad", systemImage: "flask") {
                QuoteView(show: "Breaking Bad")
//                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
            }
            
            Tab("Better Call Saul", systemImage: "briefcase") {
                QuoteView(show: "Better Call Saul")
            }
            
        }.preferredColorScheme(.dark)
    }
}

#Preview {
    MainView()
}
