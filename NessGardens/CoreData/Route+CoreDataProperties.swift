//
//  Route+CoreDataProperties.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 19.04.2023.
//
//

import Foundation
import CoreData
import CoreLocation


extension Route {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Route> {
        return NSFetchRequest<Route>(entityName: "Route")
    }

    @NSManaged public var accessible: Bool
    @NSManaged public var coordinates: [CLLocationCoordinate2D]?
    @NSManaged public var difficulty: String?
    @NSManaged public var distance: Double
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var summary: String?
    @NSManaged public var type: String?
    @NSManaged public var points: NSSet?
    
    public var wrappedName: String {
        name ?? "No Route"
    }

    public var wrappedSummary: String {
        summary ?? "No Description"
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
    
    public var pointsArray: [Point] {
        let set = points as? Set<Point> ?? []
        
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }

}

// MARK: Generated accessors for points
extension Route {

    @objc(addPointsObject:)
    @NSManaged public func addToPoints(_ value: Point)

    @objc(removePointsObject:)
    @NSManaged public func removeFromPoints(_ value: Point)

    @objc(addPoints:)
    @NSManaged public func addToPoints(_ values: NSSet)

    @objc(removePoints:)
    @NSManaged public func removeFromPoints(_ values: NSSet)

}

extension Route : Identifiable {
    func getTypeEnum() -> RouteType {
        return RouteType(rawValue: self.wrappedType) ?? .exercise
    }
    
    func getDifficultyEnum() -> RouteDifficulty {
        return RouteDifficulty(rawValue: self.wrappedDifficulty) ?? .medium
    }
}
