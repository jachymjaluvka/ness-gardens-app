//
//  AddNewPointNoRouteView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 14.04.2023.
//

import SwiftUI
import CoreLocationUI

struct AddNewPointNoRouteView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var pointsViewModel: PointsViewModel
    @StateObject var locationManager = LocationManager()
    
    @State private var name = ""
    @State private var description = ""
    @State private var longitute = ""
    @State private var latitude = ""
    
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
                    Button("Current Location", action: useCurrentLocation)
                }
                
                Section(header: Text("Route")) {
                    Text("No routes created").font(.callout)
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
            .onAppear()
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
        pointsViewModel.addNewPoint(name: name,
                                    summary: description,
                                    latitude: Float(latitude) ?? 0,
                                    longitude: Float(longitute) ?? 0,
                                    routeId: nil)
        dismiss()
    }
    
    func reset() -> Void {
    }

}

struct AddNewPOINoRouteView_Previews: PreviewProvider {
    static var previews: some View {
        let dc = DataController()
        AddNewPointNoRouteView()
            .environmentObject(PointsViewModel(dataController: dc))
            .environmentObject(LocationManager())
    }
}
