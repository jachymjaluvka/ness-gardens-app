//
//  PointAnnotation.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 20.04.2023.
//

import Foundation
import MapKit

class PointAnnotation: NSObject, MKAnnotation {
    
    let point: Point
    @objc dynamic var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(point: Point, coordinates: CLLocationCoordinate2D, title: String?, subtitle: String?) {
        self.point = point
        self.coordinate = coordinates
        self.title = title
        self.subtitle = subtitle
    }
    
}
