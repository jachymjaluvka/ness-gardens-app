//
//  Route+CoreDataProperties.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 14.04.2023.
//
//

import Foundation
import CoreData
import MapKit

extension Route {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Route> {
        return NSFetchRequest<Route>(entityName: "Route")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var summary: String?
    @NSManaged public var distance: Double
    @NSManaged public var coordinates: [CLLocationCoordinate2D]?
    @NSManaged public var type: String?
    @NSManaged public var difficulty: String?
    @NSManaged public var accessible: Bool
    
    public var wrappedName: String {
        name ?? "Unknown"
    }
    
    public var wrappedSummary: String {
        summary ?? "Unknown Description"
    }
    
    public var wrappedCoordinates: [CLLocationCoordinate2D] {
        coordinates ?? []
    }
    
    public var wrappedType: String {
        type ?? "Excercise"
    }
    
    public var wrappedDifficulty: String {
        difficulty ?? "Easy"
    }
}

extension Route : Identifiable {
    func getTypeEnum() -> RouteType {
        return RouteType(rawValue: self.wrappedType) ?? .exercise
    }
}
