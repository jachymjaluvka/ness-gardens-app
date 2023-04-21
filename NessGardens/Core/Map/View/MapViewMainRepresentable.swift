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
    
    @EnvironmentObject var dataVM: DataController
    @Binding var pointClicked: Bool
    @Binding var point: Point?
    
    var firstUpdate = true
    var wasShowingRoute = false

    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .none
        
        mapView.removeOverlays(mapView.overlays)
        mapView.removeAnnotations(mapView.annotations)
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
        if dataVM.isRouteSelected {
            
            guard let route = dataVM.selectedRoute else { return }
            context.coordinator.addPolyline(coordinates: route.wrappedCoordinates)
            
            context.coordinator.addAnnotation(withCoordinate: route.wrappedCoordinates.first!, title: "Start")
            context.coordinator.addAnnotation(withCoordinate: route.wrappedCoordinates.last!, title: "End")
            
            for point in route.pointsArray {
                context.coordinator.addAnnotation(withCoordinate: point.coordinates, title: point.wrappedName)
            }
                
        } else {
            mapView.removeOverlays(mapView.overlays)
        }
        
        for point in dataVM.allPoints {
            context.coordinator.addAnnotation(withCoordinate: point.coordinates, title: point.wrappedName)
        }
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}

extension MapViewMainRepresentable {
    
    class MapCoordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewMainRepresentable
        
        init(parent: MapViewMainRepresentable) {
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
            
            if parent.firstUpdate {
                let region = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,
                                                   longitude: userLocation.coordinate.longitude),
                    span: MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
                )
                
                parent.mapView.setRegion(region, animated: true)
                
                parent.firstUpdate = false
            }
            
            if parent.dataVM.isRouteSelected {
                parent.wasShowingRoute = true
                
                if let route = parent.dataVM.selectedRoute {
                    var closePoints = route.pointsArray.filter({ point in
                        point.coordinates.distance(from: userLocation.coordinate) < 15
                    })
                    
                    if closePoints.count > 0 {
                        if parent.point != closePoints.first {
                            parent.pointClicked = true
                            parent.point = closePoints.first
                        }
                    }
                }
                
                
            }
            
            if !parent.dataVM.isRouteSelected && parent.wasShowingRoute {
                parent.mapView.removeOverlays(parent.mapView.overlays)
                parent.mapView.removeAnnotations(parent.mapView.annotations)
                
                parent.wasShowingRoute = false
            }
        }
        
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {

        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .systemBlue
            renderer.lineWidth = 6
            return renderer
        }
        
        func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
            
            let points = parent.dataVM.allPoints.filter { $0.wrappedName == annotation.title }
            
            guard let point = points.first else { return }
            
            parent.pointClicked = true
            parent.point = point
        }
        
        func addPolyline(coordinates: [CLLocationCoordinate2D]) {
            parent.mapView.removeOverlays(parent.mapView.overlays)
            let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
            parent.mapView.addOverlay(polyline)
        }
        
        func addAnnotation(withCoordinate coordinate: CLLocationCoordinate2D, title: String = "") {
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            anno.title = title
            parent.mapView.addAnnotation(anno)
        }
        
        func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D, title: String = "") {
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            anno.title = title
            parent.mapView.addAnnotation(anno)
            parent.mapView.selectAnnotation(anno, animated: false)
        }
        
        func removeEverything() {
            parent.mapView.removeOverlays(parent.mapView.overlays)
            parent.mapView.removeAnnotations(parent.mapView.annotations)
        }
        
        
    }
}
