//
//  RouteFilterOptions.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 20.04.2023.
//

import Foundation

struct RouteFilterOptions {
    var name: String = ""
    var minDistance: Double = 0
    var maxDistance: Double = 100
    var difficulty: String = "All"
    var type: String = "All"
    var accessible: Bool = false
    
    func doesRouteConform(route: Route) -> Bool {
        var doesConform = true
        
        if name != "" && !route.wrappedName.contains(name) {
            doesConform = false
        }
        
        if route.distance < minDistance || route.distance > maxDistance {
            doesConform = false
        }
        
        if difficulty != "All" && route.difficulty != difficulty {
            doesConform = false
        }
        
        if type != "All" && route.type != type {
            doesConform = false
        }
        
        if accessible && route.accessible != accessible {
            doesConform = false
        }
        
        return doesConform
    }
}
