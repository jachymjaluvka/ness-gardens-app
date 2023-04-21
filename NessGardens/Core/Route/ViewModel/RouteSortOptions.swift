//
//  RouteSortOptions.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 20.04.2023.
//

import Foundation

enum RouteSortOption: CustomStringConvertible, Identifiable, CaseIterable {
    case name
    case distance
    case points
    
    var id: Self { self }
    
    var description: String {
        switch self {
        case .name:
            return "Name"
        case .distance:
            return "Distance"
        case .points:
            return "POIs"
        }
    }
}
