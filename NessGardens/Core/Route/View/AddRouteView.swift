//
//  AddRouteView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 14.04.2023.
//

import SwiftUI
import MapKit

struct AddRouteView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var dataVM: DataController
    @EnvironmentObject var recordVM: RecordViewModel
    
    @State var name: String = ""
    @State var description: String = ""
    @State var selectedDifficulty = "Easy"
    @State var selectedType = "Excercise"
    @State var accessible = false
    
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
                    MapViewRouteRepresentable(route: recordVM.routeCoordinates, points: recordVM.routePoints)
                        .frame(height: 250)
                    Text(String(format: "Distance: %.3f km", recordVM.distance/1000)).bold()
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
                    if recordVM.routePoints.count > 0 {
                        List {
                            ForEach(recordVM.routePoints, id: \.self) { point in
                                PointNavLinkView(point: point)
                            }
                        }
                    } else {
                        Text("No points of interest in this route.")
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
                
            }
            .navigationTitle("Add Route")
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
        dataVM.addNewRoute(name: name,
                           summary: description,
                           distance:recordVM.distance,
                           coordinates: recordVM.routeCoordinates,
                           type: selectedType,
                           difficulty: selectedDifficulty,
                           accessible: accessible,
                           routePoints: recordVM.routePoints
        )
        
        recordVM.endRecording()
        dismiss()
    }
    
    func reset() -> Void {
        name = ""
        description = ""
        selectedDifficulty = "Easy"
        selectedType = "Excercise"
    }
    
    func formatCoordinate(coord: CLLocationCoordinate2D?) -> Float {
        return Float(coord?.longitude ?? 0)
    }
}

struct AddRouteView_Previews: PreviewProvider {
    static var previews: some View {
        let dc = DataController()
        AddRouteView()
            .environmentObject(dc)
            .environmentObject(RecordViewModel(lm: LocationManager()))
    }
}
