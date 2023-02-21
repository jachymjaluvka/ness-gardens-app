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
    
    init(name: String, description: String, distance: Float){
        self.name = name
        self.description = description
        self.distance = distance
    }
    
    public func save(){
        return
    }
    
    public func share(){
        return
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

