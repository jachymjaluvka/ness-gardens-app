//
//  ContentView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 13.02.2023.
//

import SwiftUI

struct ContentView: View {
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
            
            POIView()
                .tabItem {
                    Label("POIs", systemImage: "star")
                }.tag("poi")
            
            SettingsView()
                .tabItem{
                    Label("Settings", systemImage: "slider.horizontal.3")
                }.tag("settings")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
