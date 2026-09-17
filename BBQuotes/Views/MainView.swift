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
                ShowView(show: Constants.breakingBad)
            }
            
            Tab(Constants.betterCaulSaul, systemImage: "briefcase") {
                ShowView(show: Constants.betterCaulSaul)
            }
            
            Tab(Constants.elCamino, systemImage: "car.rear.road.lane.dashed") {
                ShowView(show: Constants.elCamino)
            }
            
        }.preferredColorScheme(.dark)
    }
}

#Preview {
    MainView()
}
