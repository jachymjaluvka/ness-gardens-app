//
//  AddPOIView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 17.02.2023.
//

import SwiftUI

struct AddPOIView: View {
    let poi: POI?
    let heading: String
    @State private var name: String
    @State private var description: String
    @State private var longitute: String
    @State private var latitude: String
    
    init(poi: POI?) {
        self.poi = poi
        
        if poi == nil {
            self.heading = "Point of Interest"
            self.longitute = ""
            self.latitude = ""
        } else {
            self.heading = "Edit - \(poi!.name)"
            self.longitute = String(format: "%f", poi!.coordinates.0)
            self.latitude = String(format: "%f", poi!.coordinates.1)
        }
        
        self.name = poi?.name ?? ""
        self.description = poi?.description ?? ""
    }
    
    var body: some View {
        
        NavigationView{
            Form {
                Section(header: Text("Name + Description")) {
                    TextField("Name", text: $name)
                    TextEditor(text: $description)
                }
                
                Section(header: Text("Location")){
                    TextField("Longitude", text: $longitute)
                    TextField("Latitude", text: $latitude)
                    Button("Use current location", action: useCurrentLocation)
                }
                        
                Section(header: Text("Route")) {
                }
            }
            .navigationTitle(heading)
            .toolbar {
                ToolbarItem(placement: .automatic){
                    Button("Save", action: useCurrentLocation)
                }
            }
        }
    }
    
    func useCurrentLocation() -> Void {
        
    }
    
    func save() -> Void {
        if poi != nil {
            update()
        } else {
            saveNew()
        }
    }
    
    func update() -> Void {
        
    }
    
    func saveNew() -> Void {
        
    }
}

struct AddPOIView_Previews: PreviewProvider {
    static var previews: some View {
        AddPOIView(poi: testPOI)
    }
}
