//
//  POI.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 16.02.2023.
//

import Foundation


class POI: Identifiable {
    
    public let id: UUID = UUID()
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
