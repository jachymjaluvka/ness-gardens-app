//
//  HomeView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 13.02.2023.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedTab = "map"
    var body: some View {
        TabView(selection: $selectedTab) {
            RoutesView()
                .tabItem{
                    Label("Routes", systemImage: "figure.walk")
                }.tag("routes")
            
            MapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }.tag("map")
            
            RecordView()
                .tabItem{
                    Label("Record", systemImage: "plus.app")
                }.tag("record")
            
            PointsView()
                .tabItem {
                    Label("POIs", systemImage: "star")
                }.tag("poi")
            
            TimerPlayground()
                .tabItem {
                    Label("Timer", systemImage: "slider.horizontal.3")
                }.tag("timer")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let dc = DataController()
        HomeView()
            .environmentObject(dc)
    }
}
