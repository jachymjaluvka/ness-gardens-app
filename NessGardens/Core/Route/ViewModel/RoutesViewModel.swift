//
//  RoutesViewModel.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 13.04.2023.
//

import Foundation
import MapKit

class RoutesViewModel: ObservableObject {
    
    @Published public var allRoutes : [Route]
    @Published public var filteredRoutes : [Route]
    
    @Published public var isRouteSelected: Bool = false
    @Published public var selectedRoute: Route? = nil
    
    private var dc: DataController
    
    init(dataController: DataController) {
        self.dc = dataController
        self.allRoutes = dataController.fetchRoutes()
        self.filteredRoutes = dataController.fetchRoutes()
    }
    
    public func addNewRoute(name: String,
                            summary: String,
                            distance: Double,
                            coordinates: [CLLocationCoordinate2D],
                            type: String,
                            difficulty: String,
                            accessible: Bool
    ) -> Void {
        let newRoute = Route(context: dc.container.viewContext)
        newRoute.id = UUID()
        newRoute.name = name
        newRoute.distance = distance
        newRoute.summary = summary
        newRoute.coordinates = coordinates
        newRoute.type = type
        newRoute.difficulty = difficulty
        newRoute.accessible = accessible
        dc.save()
        allRoutes = dc.fetchRoutes()
    }
    
    public func deleteRoute(route: Route) -> Void {
        dc.container.viewContext.delete(route)
        dc.save()
        allRoutes = dc.fetchRoutes()
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
        dc.save()
        allRoutes = dc.fetchRoutes()
    }
    
    public func selectRoute(route: Route) -> Void {
        isRouteSelected = true
        selectedRoute = route
    }
    
    public func stopRouting() -> Void {
        isRouteSelected = false
        selectedRoute = nil
    }
    
}
