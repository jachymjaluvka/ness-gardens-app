//
//  DataController.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 14.04.2023.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "NessGardens")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load \(error.localizedDescription)")
            } else {
                print("Data loaded successfully")
            }
        }
    }
    
    func fetchRoutes() -> [Route] {
        let request = NSFetchRequest<Route>(entityName: "Route")
        
        do {
            let results = try container.viewContext.fetch(request)
            return results
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
        }
        
        return []
    }
    
    func fetchPoints() -> [Point] {
        let request = NSFetchRequest<Point>(entityName: "Point")
        
        do {
            let results = try container.viewContext.fetch(request)
            return results
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
        }
        
        return []
    }
    
    func save() -> Void {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving. \(error.localizedDescription)")
        }
    }
}
