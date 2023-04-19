//
//  DataController.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 14.04.2023.
//

import CoreData
import Foundation
import CoreLocation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "NessGardens")
    
    // Routes
    @Published var allRoutes: [Route] = []
    @Published var filteredRoutes: [Route] = []
    @Published var isRouteSelected: Bool = false
    @Published var selectedRoute: Route? = nil
    
    // Points
    @Published var allPoints: [Point] = []
    @Published var filteredPoints: [Point] = []
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load \(error.localizedDescription)")
            } else {
                print("Data loaded successfully")
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
        
        allRoutes = fetchRoutes()
        filteredRoutes = fetchRoutes()
        
        allPoints = fetchPoints()
        filteredPoints = fetchPoints()
    }
    
    // MARK: Route Functions
    
    func fetchRoutes() -> [Route] {
        let request = NSFetchRequest<Route>(entityName: "Route")
        
        do {
            let results = try container.viewContext.fetch(request)
            return results
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
        }
        
        return []
    }
    
    public func addNewRoute(name: String,
                            summary: String,
                            distance: Double,
                            coordinates: [CLLocationCoordinate2D],
                            type: String,
                            difficulty: String,
                            accessible: Bool
    ) -> Void {
        let newRoute = Route(context: container.viewContext)
        newRoute.id = UUID()
        newRoute.name = name
        newRoute.distance = distance
        newRoute.summary = summary
        newRoute.coordinates = coordinates
        newRoute.type = type
        newRoute.difficulty = difficulty
        newRoute.accessible = accessible
        
        save()
    }
    
    public func deleteRoute(route: Route) -> Void {
        container.viewContext.delete(route)
        save()
    }
    
    public func updateRoute(route: Route,
                            name: String,
                            summary: String,
                            distance: Double,
                            coordinates: [CLLocationCoordinate2D],
                            type: String,
                            difficulty: String,
                            accessible: Bool
    ) -> Void {
        route.id = UUID()
        route.name = name
        route.distance = distance
        route.summary = summary
        route.coordinates = coordinates
        route.type = type
        route.difficulty = difficulty
        route.accessible = accessible
        
        save()
    }
    
    
    // MARK: Point functions
    
    func fetchPoints() -> [Point] {
        let request = NSFetchRequest<Point>(entityName: "Point")
        
        do {
            let results = try container.viewContext.fetch(request)
            return results
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
        }
        
        return []
    }
    
    public func addNewPoint(name: String,
                            summary: String,
                            latitude: Float,
                            longitude: Float,
                            route: Route?
    )-> Void {
        let newPoint = Point(context: container.viewContext)
        newPoint.id = UUID()
        newPoint.name = name
        newPoint.summary = summary
        newPoint.latitude = latitude
        newPoint.longitude = longitude
        newPoint.route = route
    
        save()
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
        point.route = route
        
        save()
    }
    
    public func deletePoint(point: Point) -> Void {
        container.viewContext.delete(point)
        save()
        allPoints = fetchPoints()
    }
    
    func save() -> Void {
        if container.viewContext.hasChanges{
            do {
                try container.viewContext.save()
            } catch let error {
                print("Error saving. \(error.localizedDescription)")
            }
            
            allRoutes = fetchRoutes()
            allPoints = fetchPoints()
        }
    }
    
    func fetchRoutePoints(route: Route) -> [Point] {
        let request: NSFetchRequest<Point> = Point.fetchRequest()
        request.predicate = NSPredicate(format: "route = %@", route)
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        var fetchedPoints: [Point] = []
        
        do {
            fetchedPoints = try container.viewContext.fetch(request)
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
        return fetchedPoints
    }
}
