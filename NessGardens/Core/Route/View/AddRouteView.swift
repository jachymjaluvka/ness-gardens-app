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
    @EnvironmentObject var routesViewModel: RoutesViewModel
    
    @State var name: String = ""
    @State var description: String = ""
    @State var selectedDifficulty = "Easy"
    @State var selectedType = "Excercise"
    
    let difficulties = ["Easy", "Medium", "Hard"]
    let types = ["Excercise", "Informative", "Exploration", "Leisure"]
    let distance = "12.5km"
    
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
                    MapViewRepresentable()
                        .frame(height: 250)
                    Text("Distance: \(distance)").bold()
                }

                Section("Extra") {
                    Picker("Difficulty", selection: $selectedDifficulty){
                        ForEach(difficulties, id: \.self)  {
                            Text($0)
                        }
                    }
                    
                    Picker("Type", selection: $selectedType){
                        ForEach(types, id: \.self)  {
                            Text($0)
                        }
                    }
                }
                
                Section("Points") {
                    List {
                        
                    }
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
        routesViewModel.addNewRoute(name: name,
                                    summary: description,
                                    coordinates: [CLLocationCoordinate2D(latitude: 50.073658,
                                                                         longitude: 14.418540),
                                                  CLLocationCoordinate2D(latitude: 51.073658,
                                                                         longitude: 15.418540)
                                    ],
                                    type: selectedType,
                                    difficulty: selectedDifficulty
        )
        dismiss()
    }
    
    func reset() -> Void {
        
    }
}

struct AddRouteView_Previews: PreviewProvider {
    static var previews: some View {
        let dc = DataController()
        let vm = RoutesViewModel(dataController: dc)
        AddRouteView()
            .environmentObject(vm)
    }
}
