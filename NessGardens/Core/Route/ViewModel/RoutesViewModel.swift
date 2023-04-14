//
//  RoutesViewModel.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 13.04.2023.
//

import Foundation

class RoutesViewModel: ObservableObject {
    
    @Published public var allRoutes : Array<Route>
    @Published public var filteredRoutes : Array<Route>
    
    init() {
        self.allRoutes = RoutesViewModel.getAllRoutes()
        self.filteredRoutes = RoutesViewModel.getAllRoutes()
    }

    private static func getAllRoutes() -> Array<Route> {
        return [Route(name: "First Route",
                      description: "Some random first route",
                      distance: 12.56),
                Route(name: "Second Route",
                      description: "Some random second route",
                      distance: 15.32)
        ]
    }
}
