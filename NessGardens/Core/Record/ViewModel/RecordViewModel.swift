//
//  RecordViewModel.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 16.04.2023.
//

import Foundation
import Combine
import MapKit

class RecordViewModel: ObservableObject {
    @Published var elapsedSeconds: Int = 0
    @Published var distance: Double = 0
    @Published var routeCoordinates: [CLLocationCoordinate2D] = []
    @Published var routePoints: [Point] = []
    @Published var recording: Bool = false
    @Published var timeStringRepresentaion: String
    
    private var timer: AnyCancellable?
    private var locationManager: LocationManager
    private var coordinateID: Int = 0
    
    init(lm: LocationManager) {
        timeStringRepresentaion = "00:00:00"
        locationManager = lm
    }
    
    public func startTimer() -> Void {
        
        if elapsedSeconds == 0 {
            guard let coordinate = self.locationManager.location else { return }
            routeCoordinates.append(coordinate)
        }
        
        recording = true
        timer = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                self.elapsedSeconds += 1
                self.formatSeconds()
                
                if self.elapsedSeconds % 5 == 0 {
                    guard let coordinate = self.locationManager.location else { return }
                    self.routeCoordinates.append(coordinate)
                    
                    self.distance += coordinate.distance(from: self.routeCoordinates[self.coordinateID])
                    self.coordinateID += 1
                }
            }
    }
    
    public func stopTimer() -> Void {
        recording = false
        timer?.cancel()
    }
    
    public func endRecording() -> Void {
        elapsedSeconds = 0
        formatSeconds()
        routeCoordinates = []
        routePoints = []
        coordinateID = 0
        distance = 0
    }
    
    public func formatSeconds() -> Void {
        var minutes = Int(elapsedSeconds / 60)
        let hours = Int(minutes / 60)
        
        minutes = minutes % 60
        let seconds = elapsedSeconds % 60
        
        
        
        timeStringRepresentaion = String(format: "%02d", hours) + ":" + String(format: "%02d", minutes) + ":" + String(format: "%02d", seconds)
    }
}
