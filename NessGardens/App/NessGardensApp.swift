//
//  NessGardensApp.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 13.02.2023.
//

import SwiftUI

@main
struct NessGardensApp: App {
    var body: some Scene {
        WindowGroup {
            let dc = DataController()
            HomeView()
                .environmentObject(RoutesViewModel(dataController: dc))
                .environmentObject(PointsViewModel(dataController: dc))
                .environmentObject(RecordViewModel(lm: LocationManager()))
        }
    }
}
