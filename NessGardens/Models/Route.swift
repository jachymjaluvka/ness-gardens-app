//
//  Route.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 14.02.2023.
//

import Foundation


enum Output{
    case csv
    case plain
}



class Route: Identifiable {
    public let id: UUID = UUID()
    public var name: String
    public var description: String
    public var distance: Float
    public var coordinates: [(Float, Float)]
    
    init(name: String, description: String, distance: Float, coordinates: [(Float, Float)]? = nil){
        self.name = name
        self.description = description
        self.distance = distance
        self.coordinates = coordinates ?? []
    }
    
    public func save(){
        return
    }
    
    public func share(){
        return
    }
    
    public func addCoordinate(longitude: Float, latitude: Float) -> Void {
        self.coordinates.append((longitude, latitude))
    }
    
    public func addCoordinate(coordinate: (Float, Float)) -> Void {
        self.coordinates.append(coordinate)
    }
    
    private func outputAsCsv(){
        return
    }
    
    public func output(format: Output){
        switch format {
        case .csv:
            print("outputting as csv")
        case .plain:
            print("exporting as plaintext")
        }
    }
    
}

