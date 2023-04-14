//
//  AddPOIView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 17.02.2023.
//

import SwiftUI

struct AddNewPOIView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var description = ""
    @State private var longitute = ""
    @State private var latitude = ""
    
    @EnvironmentObject var routesViewModel: RoutesViewModel
    @State var selectedRoute = 0
    
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
            .navigationTitle("Add POI")
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

struct AddNewPOIView_Previews: PreviewProvider {
    static var previews: some View {
        let routesVM = RoutesViewModel()
        AddNewPOIView().environmentObject(routesVM)
    }
}
