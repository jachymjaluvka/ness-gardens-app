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
    
    @EnvironmentObject var routesViewModel: RoutesViewModel
    @EnvironmentObject var pointsViewModel: PointsViewModel
    @StateObject var locationManager = LocationManager()
    @State private var selectedRoute: Route
    
    init(firstRoute: Route) {
        _selectedRoute = State(initialValue: firstRoute)
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
                    TextField("Latitude", text: $latitude)
                    TextField("Longitude", text: $longitute)
                    Button("Use current location", action: useCurrentLocation)
                }
                
                Section(header: Text("Route")) {
                    Picker(selection: $selectedRoute, label: Text("Routes")) {
                        ForEach(routesViewModel.allRoutes) { (route: Route) in
                            Text(route.wrappedName)
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
                                    routeId: selectedRoute.id)
        dismiss()
    }
    
    func reset() -> Void {
        selectedRoute = routesViewModel.allRoutes[0]
    }

}

struct AddNewPOIView_Previews: PreviewProvider {
    static var previews: some View {
        let dc = DataController()
        let routesVM = RoutesViewModel(dataController: dc)
        let pointsVM = PointsViewModel(dataController: dc)
        AddNewPointView(firstRoute: routesVM.allRoutes[0])
            .environmentObject(routesVM)
            .environmentObject(pointsVM)
    }
}
