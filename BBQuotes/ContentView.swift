//
//  ContentView.swift
//  BBQuotes
//
//  Created by Olivier Sbg on 07/09/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Breaking Bad", systemImage: "flask") {
                Text("Breaking Bad stuff")
//                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
            }
            
            Tab("Better Call Saul", systemImage: "briefcase") {
                Text("Better Call Saul stuff")
            }
        }
    }
}

#Preview {
    ContentView()
}
