//
//  RouteEditView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 20.04.2023.
//

import SwiftUI
import CoreLocation

struct RouteEditView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var dataVM: DataController
    
    @State var name: String
    @State var description: String
    @State var selectedDifficulty: String
    @State var selectedType: String
    @State var accessible: Bool
    
    var route: Route
    
    init(route: Route) {
        _name = State(initialValue: route.wrappedName)
        _description = State(initialValue: route.wrappedSummary)
        _selectedDifficulty = State(initialValue: route.difficulty ?? "Easy")
        _selectedType = State(initialValue: route.type ?? "Excercise")
        _accessible = State(initialValue: route.accessible)
        self.route = route
    }
    
    let difficulties = ["Easy", "Medium", "Hard"]
    let types = ["Excercise", "Informative", "Exploration", "Leisure"]
    
    var body: some View {
        NavigationView {
            Form {
                Section("Name") {
                    TextField("Name", text: $name)
                }
                
                Section("Description") {
                    TextEditor(text: $description)
                }
                
                Section ("Map") {
                    MapViewRouteRepresentable(route: route.wrappedCoordinates, points: route.pointsArray)
                        .frame(height: 250)
                    Text(String(format: "Distance: %.3f km", route.distance/1000)).bold()
                }
                
                Section("Extra") {
                    Picker("Difficulty", selection: $selectedDifficulty) {
                        ForEach(difficulties, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    Picker("Type", selection: $selectedType) {
                        ForEach(types, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    Toggle(isOn: $accessible) {
                        Text("Accessible")
                    }
                }
                
                Section("Points") {
                    Divider()
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
                
            }
            .navigationTitle("Update Route")
            .toolbar {
                ToolbarItem(placement: .automatic){
                    Button("Close", action: close)
                }
            }
        }
    }
    
    func close() -> Void {
        dismiss()
    }
    
    func save() -> Void {
        dataVM.updateRoute(route: route,
                           name: name,
                           summary: description,
                           distance:route.distance,
                           coordinates: route.wrappedCoordinates,
                           type: selectedType,
                           difficulty: selectedDifficulty,
                           accessible: accessible
        )
        
        dismiss()
    }
    
    func reset() -> Void {
        name = route.wrappedName
        description = route.wrappedSummary
        selectedDifficulty = route.difficulty ?? "Easy"
        selectedType = route.type ?? "Excercise"
        accessible = route.accessible
    }
    
    func formatCoordinate(coord: CLLocationCoordinate2D?) -> Float {
        return Float(coord?.longitude ?? 0)
    }
}

struct RouteEditView_Previews: PreviewProvider {
    static var previews: some View {
        let dc = DataController()
        
        let context = dc.container.viewContext
        let testRoute = Route(context: context)
        
        RouteEditView(route: testRoute)
            .environmentObject(dc)
    }
}
