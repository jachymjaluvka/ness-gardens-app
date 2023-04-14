//
//  POI.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 16.02.2023.
//

import Foundation


class POI: Identifiable {
    public var name: String
    public var description: String
    public var coordinates: (Float, Float)
    public var imagePath: String?
    
    init(name: String, description: String, latitude: Float, longitude: Float, image: String? = nil){
        self.name = name
        self.description = description
        self.coordinates = (latitude, longitude)
        
        self.imagePath = image
    }
    
    public func addImage(path: String) -> Void{
        self.imagePath = path
    }
    
    public func hasImage() -> Bool{
        if self.imagePath != nil {
            return true
        }else{
            return false
        }
    }
}

extension POI: Hashable {
    
    var id: String {
        return UUID().uuidString
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    static func == (lhs: POI, rhs: POI) -> Bool {
        return lhs.name == rhs.name
    }
}
