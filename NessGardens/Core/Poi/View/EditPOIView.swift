//
//  EditPOIView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 13.04.2023.
//

import SwiftUI

struct EditPOIView: View {
    @Environment(\.dismiss) var dismiss
    
    public var poi: POI
    
    @State private var name: String
    @State private var description: String
    @State private var longitute: String
    @State private var latitude: String
    
    @EnvironmentObject var routesViewModel: RoutesViewModel
    @State var selectedRoute = 0
    
    init(poi: POI) {
        self.poi = poi
        _name = State(initialValue: poi.name)
        _description = State(initialValue: poi.description)
        _latitude = State(initialValue: String(poi.coordinates.0))
        _longitute = State(initialValue: String(poi.coordinates.1))
    }
    
    var body: some View {
        
        NavigationView {
            Form {
                Section("Name") {
                    TextField("Name", text: $name)
                }
                
                Section("Description") {
                    TextEditor(text: $description)
                }
                
                Section("Location"){
                    TextField("Longitude", text: $longitute)
                    TextField("Latitude", text: $latitude)
                    Button("Use current location", action: useCurrentLocation)
                }
                
                Section(header: Text("Route")) {
                    Picker(selection: $selectedRoute, label: Text("Routes")) {
                        ForEach(0 ..< self.routesViewModel.allRoutes.count) { route in
                            Text(self.routesViewModel.allRoutes[route].name).tag(route)
                        }
                    }
                }
                
                HStack {
                    Spacer()
                    Button("Save", action: save)
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .fontWeight(.semibold)
                    Button("Reset", action: reset)
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .fontWeight(.semibold)
                        .tint(Color.gray)
                    Spacer()
                }
            
            }
            .navigationTitle("Edit - \(poi.name)")
            .toolbar {
                ToolbarItem(placement: .automatic){
                    Button("Close", action: close)
                }
            }
        }
    }
    
    func useCurrentLocation() -> Void {
        
    }
    
    func close() -> Void {
        dismiss()
    }
    
    func save() -> Void {
        print(selectedRoute)
        dismiss()
    }
    
    func reset() -> Void {
        selectedRoute = 0
    }

}

struct EditPOIView_Previews: PreviewProvider {
    static var previews: some View {
        EditPOIView(poi: POI(name: "Test POI",
                             description: "Some longer string for description",
                             latitude: 12.56754,
                             longitude: 142.4647895)
        ).environmentObject(RoutesViewModel())
    }
}
