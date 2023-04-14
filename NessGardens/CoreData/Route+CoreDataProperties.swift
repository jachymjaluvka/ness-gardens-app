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
    @NSManaged public var distance: Float
    @NSManaged public var coordinates: [CLLocationCoordinate2D]?
    @NSManaged public var type: String?
    @NSManaged public var difficulty: String?
    
    public var wrappedName: String {
        name ?? "Unknown"
    }
    
    public var wrappedSummary: String {
        summary ?? ""
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

}
