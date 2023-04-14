//
//  Point+CoreDataProperties.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 14.04.2023.
//
//

import Foundation
import CoreData


extension Point {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Point> {
        return NSFetchRequest<Point>(entityName: "Point")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var summary: String?
    @NSManaged public var latitude: Float
    @NSManaged public var longitude: Float
    @NSManaged public var routeId: UUID?
    
    public var wrappedName: String {
        name ?? "Unknown"
    }
    
    public var wrappedSummary: String {
        summary ?? ""
    }

}

extension Point : Identifiable {

}
