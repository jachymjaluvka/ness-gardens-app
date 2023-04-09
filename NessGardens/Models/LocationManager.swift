//
//  LocationManager.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 21.03.2023.
//

import MapKit

enum MapDetails {
    static let defaultLocation = CLLocationCoordinate2D(latitude: 40.83834587046632,
                                                        longitude: 14.254053016537693)
    
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
}

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    var manager: CLLocationManager?
    @Published var region = MKCoordinateRegion(
        center: MapDetails.defaultLocation,
        span: MapDetails.defaultSpan
    )
    
    public func locationServicesEnabled() -> Void {
        if CLLocationManager.locationServicesEnabled() {
            manager = CLLocationManager()
            manager?.activityType = CLActivityType.fitness
            manager?.delegate = self
        } else {
            print("Show alert to tell user to enable location service")
        }
    }
    
    private func locationManagerAuthorised() -> Void {
        guard let manager = manager else { return }
        
        switch manager.authorizationStatus {
            
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
            case .restricted:
                print("Your location is restricted")
            case .denied:
                print("You have denied this app location permission. Please enable it in your settings.")
            case .authorizedAlways, .authorizedWhenInUse:
                region = MKCoordinateRegion(center: manager.location?.coordinate ?? MapDetails.defaultLocation,
                                            span: MapDetails.defaultSpan)
                print(manager.location?.coordinate)
            @unknown default:
                break
            }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationManagerAuthorised()
    }
    
}
