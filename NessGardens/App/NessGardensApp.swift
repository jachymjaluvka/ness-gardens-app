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
            HomeView()
                .environmentObject(DataController())
                .environmentObject(RecordViewModel(lm: LocationManager()))
                .environment(\.managedObjectContext, DataController().container.viewContext)
        }
    }
}
