//
//  EditPointView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 13.04.2023.
//

import SwiftUI

struct EditPointView: View {
    @Environment(\.dismiss) var dismiss
    
    public var point: Point
    
    @State private var name: String
    @State private var description: String
    @State private var longitute: String
    @State private var latitude: String
    
    @EnvironmentObject var routesViewModel: RoutesViewModel
    @State var selectedRoute: Route?
    
    init(point: Point) {
        self.point = point
        _name = State(initialValue: point.wrappedName)
        _description = State(initialValue: point.wrappedSummary)
        _latitude = State(initialValue: String(point.latitude))
        _longitute = State(initialValue: String(point.longitude))
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
            .navigationTitle("Edit - \(point.wrappedName)")
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
        //print(selectedRoute)
        dismiss()
    }
    
    func reset() -> Void {
        //selectedRoute = 0
    }

}

struct EditPOIView_Previews: PreviewProvider {
    static var previews: some View {
        let dc = DataController()
        
        let context = dc.container.viewContext
        let testPoint = Point(context: context)
        
        EditPointView(point: testPoint)
            .environmentObject(RoutesViewModel(dataController: dc))
    }
}
