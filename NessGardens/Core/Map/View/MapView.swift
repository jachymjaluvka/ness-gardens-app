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
    
    @State var showingPoint: Bool = false
    @State var point: Point? = nil
    
    
    var body: some View {
        
        MapViewMainRepresentable(pointClicked: $showingPoint, point: $point)
            .ignoresSafeArea(edges: .top)
            .fullScreenCover(isPresented: $showingPoint) {
                if point != nil {
                    PointDetailMapAnnotationView(point: point!)
                }
            }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(DataController())
    }
}
