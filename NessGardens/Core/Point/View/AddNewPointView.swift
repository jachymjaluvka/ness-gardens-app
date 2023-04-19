//
//  AddPointView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 17.02.2023.
//

import SwiftUI

struct AddNewPointView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var description = ""
    @State private var longitute = ""
    @State private var latitude = ""
    
    @EnvironmentObject var dataVM: DataController
    @StateObject var locationManager = LocationManager()
    @State private var selectedRoute: Route? = nil
    
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
                    TextField("Latitude", text: $latitude)
                    TextField("Longitude", text: $longitute)
                    Button("Use current location", action: useCurrentLocation)
                }
                
                Section(header: Text("Route")) {
                    Picker(selection: $selectedRoute, label: Text("Routes")) {
                        Text("No Route").tag(nil as Route?)
                        ForEach(dataVM.allRoutes) { (route: Route) in
                            Text(route.wrappedName).tag(route as Route?)
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
            .navigationTitle("Add Point")
            .toolbar {
                ToolbarItem(placement: .automatic){
                    Button("Close", action: close)
                }
            }
        }
    }
    
    func useCurrentLocation() -> Void {
        latitude = String(Float(locationManager.location?.latitude ?? 0))
        longitute = String(Float(locationManager.location?.longitude ?? 0))
    }
    
    func close() -> Void {
        dismiss()
    }
    
    func save() -> Void {
        dataVM.addNewPoint(name: name,
                                    summary: description,
                                    latitude: Float(latitude) ?? 0,
                                    longitude: Float(longitute) ?? 0,
                                    route: selectedRoute)
        
        print(selectedRoute?.wrappedName ?? "")
        dismiss()
    }
    
    func reset() -> Void {
        selectedRoute = nil
    }

}

struct AddNewPOIView_Previews: PreviewProvider {
    static var previews: some View {
        let dc = DataController()
        AddNewPointView()
            .environmentObject(dc)
    }
}
