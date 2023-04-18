//
//  MapViewRepresentable.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 12.04.2023.
//

import SwiftUI
import MapKit

enum MapType {
    case informative
    case recording
    case route
}

struct MapViewRepresentable: UIViewRepresentable {
    
    let mapView = MKMapView()
    let locationManager = LocationManager()
    private var type: MapType
    var showPolyline: Bool
    
    @EnvironmentObject var recordViewModel: RecordViewModel
    
    init(showPolyline: Bool, type: MapType) {
        self.type = type
        
        switch type {
        case .informative:
            self.showPolyline = false
        case .recording, .route:
            self.showPolyline = true
        }
    }
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        
        switch type {
        case .informative:
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
        case .route:
            mapView.showsUserLocation = false
            mapView.userTrackingMode = .none
        case .recording:
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
        }
        
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        context.coordinator.addPolyline(coordinates: recordViewModel.routeCoordinates)
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}

extension MapViewRepresentable {
    
    class MapCoordinator: NSObject, MKMapViewDelegate {
        let parent: MapViewRepresentable
        
        init(parent: MapViewRepresentable) {
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
            var polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
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
