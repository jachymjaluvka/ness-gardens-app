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
    
    private var dc: DataController
    
    init(dataController: DataController) {
        self.dc = dataController
        self.allRoutes = dataController.fetchRoutes()
        self.filteredRoutes = dataController.fetchRoutes()
    }
    
    public func addNewRoute(name: String,
                            summary: String,
                            coordinates: [CLLocationCoordinate2D],
                            type: String,
                            difficulty: String
    ) -> Void {
        let newRoute = Route(context: dc.container.viewContext)
        newRoute.id = UUID()
        newRoute.name = name
        newRoute.summary = summary
        newRoute.coordinates = coordinates
        newRoute.type = type
        newRoute.difficulty = difficulty
        dc.save()
        allRoutes = dc.fetchRoutes()
    }
    
}
