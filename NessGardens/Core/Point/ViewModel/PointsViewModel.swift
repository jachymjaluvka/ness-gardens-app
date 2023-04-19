//
//  POIViewModel.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 13.04.2023.
//

import Foundation

class PointsViewModel: ObservableObject {
    @Published public var allPoints: [Point]
    @Published public var filteredPoints: [Point]
    
    private var dc: DataController
    
    init(dataController: DataController) {
        self.allPoints = dataController.fetchPoints()
        self.filteredPoints = dataController.fetchPoints()
        
        self.dc = dataController
    }
    
    public func addNewPoint(name: String,
                            summary: String,
                            latitude: Float,
                            longitude: Float,
                            route: Route?
    )-> Void {
        let newPoint = Point(context: dc.container.viewContext)
        newPoint.id = UUID()
        newPoint.name = name
        newPoint.summary = summary
        newPoint.latitude = latitude
        newPoint.longitude = longitude
        newPoint.route = route
        
        route?.addToPoints(newPoint)
    
        dc.save()
        allPoints = dc.fetchPoints()
    }
    
    public func updatePoint(point: Point,
                            name: String,
                            summary: String,
                            latitude: Float,
                            longitude: Float,
                            route: Route?
    ) -> Void {
        point.id = UUID()
        point.name = name
        point.summary = summary
        point.latitude = latitude
        point.longitude = longitude
        
        point.route?.removeFromPoints(point)
        route?.addToPoints(point)
        dc.save()
        allPoints = dc.fetchPoints()
    }
    
    public func deletePoint(point: Point) -> Void {
        dc.container.viewContext.delete(point)
        dc.save()
        allPoints = dc.fetchPoints()
    }
    
}
