//
//  MapViewMainRepresentable.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 18.04.2023.
//

import SwiftUI
import MapKit

struct MapViewMainRepresentable: UIViewRepresentable {
    
    let mapView = MKMapView()
    let locationManager = LocationManager()
    
    @EnvironmentObject var routesViewModel: RoutesViewModel
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
        if routesViewModel.isRouteSelected {
            guard let route = routesViewModel.selectedRoute else { return }
            context.coordinator.addPolyline(coordinates: route.wrappedCoordinates)
        } else {
            mapView.removeOverlays(mapView.overlays)
        }
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}

extension MapViewMainRepresentable {
    
    class MapCoordinator: NSObject, MKMapViewDelegate {
        let parent: MapViewMainRepresentable
        
        init(parent: MapViewMainRepresentable) {
            self.parent = parent
            super.init()
        }
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,
                                               longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
            
            parent.mapView.setRegion(region, animated: true)
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
        
        func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            parent.mapView.addAnnotation(anno)
            parent.mapView.selectAnnotation(anno, animated: true)
            
            parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
        }
        
        
    }
}
