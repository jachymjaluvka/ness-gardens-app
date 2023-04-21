//
//  Point+CoreDataProperties.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 19.04.2023.
//
//

import Foundation
import CoreData
import CoreLocation
import PhotosUI

extension Point {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Point> {
        return NSFetchRequest<Point>(entityName: "Point")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var summary: String?
    @NSManaged public var latitude: Float
    @NSManaged public var longitude: Float
    @NSManaged public var route: Route?
    @NSManaged public var image: Data?
    
    public var wrappedName: String {
        return name ?? "Test Point"
    }
    
    public var wrappedSummary: String {
        return summary ?? "Some test summary lorem ipsum raz dva tri"
    }
    
    public var coordinates: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: Double(latitude), longitude: Double(longitude))
    }

}

extension Point : Identifiable {

}
