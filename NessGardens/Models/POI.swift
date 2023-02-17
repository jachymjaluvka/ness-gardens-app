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
    
    init(name: String, description: String, latitude: Float, longitude: Float){
        self.name = name
        self.description = description
        self.coordinates = (latitude, longitude)
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
