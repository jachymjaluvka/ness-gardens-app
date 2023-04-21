//
//  MapViewRepresentable.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 12.04.2023.
//

import SwiftUI
import MapKit

struct MapViewRecordRepresentable: UIViewRepresentable {
    
    let mapView = MKMapView()
    let locationManager = LocationManager()
    
    @EnvironmentObject var recordViewModel: RecordViewModel
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .none
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
        self.mapView.removeOverlays(self.mapView.overlays)
        self.mapView.removeAnnotations(self.mapView.annotations)
        
        context.coordinator.addPolyline(coordinates: recordViewModel.routeCoordinates)
        
        for point in recordViewModel.routePoints {
            context.coordinator.addAnnotation(withCoordinate: point.coordinates, title: point.wrappedName)
        }
        
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}

extension MapViewRecordRepresentable {
    
    class MapCoordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewRecordRepresentable
        
        init(parent: MapViewRecordRepresentable) {
            self.parent = parent
            super.init()
        }
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            
            let span = parent.mapView.region.span
            
            var longitudeDelta = 0.01
            if span.longitudeDelta < 0.5 {
                longitudeDelta = span.longitudeDelta
            }
            
            var latitudeDelta = 0.01
            if span.latitudeDelta < 0.5 {
                latitudeDelta = span.latitudeDelta
            }
            
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,
                                               longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
            )
            
            if !parent.recordViewModel.recording {
                parent.mapView.removeAnnotations(parent.mapView.annotations)
                parent.mapView.removeOverlays(parent.mapView.overlays)
            }
            
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
        
        func addAnnotation(withCoordinate coordinate: CLLocationCoordinate2D, title: String) {
            
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            anno.title = title
            parent.mapView.addAnnotation(anno)
        }
        
    }
}
