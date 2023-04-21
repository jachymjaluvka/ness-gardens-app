//
//  MapViewRouteRepresentable.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 18.04.2023.
//

import SwiftUI
import MapKit

struct MapViewRouteRepresentable: UIViewRepresentable {
    
    let mapView = MKMapView()
    let locationManager = LocationManager()
    let route: [CLLocationCoordinate2D]
    let points: [Point]
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = false
        
        let region = MKCoordinateRegion(
            center: route.first ?? CLLocationCoordinate2D(latitude: 53.400002, longitude: -2.983333),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
        
        mapView.setRegion(region, animated: true)
        
        context.coordinator.addPolyline(coordinates: route)
        
        for point in points {
            context.coordinator.addAnnotation(withCoordinate: point.coordinates, title: point.wrappedName)
        }
        
        if route.count > 0 {
            context.coordinator.addAnnotation(withCoordinate: route.first!, title: "Start")
            context.coordinator.addAnnotation(withCoordinate: route.last!, title: "End")
        }
        
        mapView.showAnnotations(mapView.annotations, animated: true)
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {

    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}

extension MapViewRouteRepresentable {
    
    class MapCoordinator: NSObject, MKMapViewDelegate {
        let parent: MapViewRouteRepresentable
        
        init(parent: MapViewRouteRepresentable) {
            self.parent = parent
            super.init()
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .systemBlue
            renderer.lineWidth = 6
            return renderer
        }
        
        func addPolyline(coordinates: [CLLocationCoordinate2D]) {
            parent.mapView.removeOverlays(parent.mapView.overlays)
            let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
            parent.mapView.addOverlay(polyline)
        }
        
        func addAnnotation(withCoordinate coordinate: CLLocationCoordinate2D, title: String) {
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            anno.title = title
            parent.mapView.addAnnotation(anno)
        }
        
        
    }
}
