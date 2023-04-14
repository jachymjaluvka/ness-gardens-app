//
//  MapView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 13.02.2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var locationManager = LocationManager()
    @State var tracking: MapUserTrackingMode = .follow
    
    var body: some View {
        MapViewRepresentable()
            .ignoresSafeArea(edges: .top)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
