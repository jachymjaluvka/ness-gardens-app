//
//  RouteFilterView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 12.04.2023.
//

import SwiftUI

struct RouteFilterView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var dataVM: DataController
    
    @State var name: String
    @State var minDistance: String
    @State var maxDistance: String
    @State var selectedDifficulty: String
    @State var selectedType: String
    @State var accessible: Bool
    
    init(options: RouteFilterOptions) {
        _name = State(initialValue: options.name)
        _minDistance = State(initialValue: String(options.minDistance))
        _maxDistance = State(initialValue: String(options.maxDistance))
        _selectedDifficulty = State(initialValue: options.difficulty)
        _selectedType = State(initialValue: options.type)
        _accessible = State(initialValue: options.accessible)
    }
    
    let difficulties = ["All", "Easy", "Medium", "Hard"]
    let types = ["All", "Excercise", "Informative", "Exploration", "Leisure"]
    
    var body: some View {
        Form {
            //Name
            Section("Name") {
                TextField("Name", text: $name)
            }
            // Distance
            Section("Distance") {
                HStack {
                    TextField("Min Distance", text: $minDistance)
                    Divider()
                    TextField("Max Distance", text: $maxDistance)
                }
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
                
                Toggle(isOn: $accessible) {
                    Text("Accessible")
                }
            }

            HStack {
                Spacer()
                Button("Filter", action: filter)
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
    
    func filter() -> Void {
        let options = RouteFilterOptions(name: name,
                                         minDistance: Double(minDistance) ?? 0,
                                         maxDistance: Double(maxDistance) ?? 100,
                                         difficulty: selectedDifficulty,
                                         type: selectedType,
                                         accessible: accessible
        )
        
        dataVM.filterRoutes(options: options)
        dismiss()
    }
    
    func reset() -> Void {
        name = ""
        minDistance = "0"
        maxDistance = "100"
        selectedDifficulty = "All"
        selectedType = "All"
        accessible = false
        
        dataVM.filteredRoutes = dataVM.allRoutes
        dataVM.sortRoutes(by: .name)
    }
}

struct RouteFilterView_Previews: PreviewProvider {
    static var previews: some View {
        RouteFilterView(options: RouteFilterOptions())
            .environmentObject(DataController())
    }
}
