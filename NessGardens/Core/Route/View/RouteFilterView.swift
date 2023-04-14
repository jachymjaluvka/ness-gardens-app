//
//  RouteFilterView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 12.04.2023.
//

import SwiftUI

struct RouteFilterView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var name = ""
    @State var minDistance = ""
    @State var maxDistance = ""
    @State var selectedDifficulty = "Easy"
    @State var selectedType = "Excercise"
    
    let difficulties = ["Easy", "Medium", "Hard"]
    let types = ["Excercise", "Informative", "Exploration", "Leisure"]
    
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
            
            Picker("Difficulty", selection: $selectedDifficulty){
                ForEach(difficulties, id: \.self)  {
                    Text($0)
                }
            }
            .pickerStyle(.inline)
            
            Picker("Type", selection: $selectedType){
                ForEach(types, id: \.self)  {
                    Text($0)
                }
            }
            .pickerStyle(.inline)
            
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
        dismiss()
    }
    
    func reset() -> Void {
        
    }
}

struct RouteFilterView_Previews: PreviewProvider {
    static var previews: some View {
        RouteFilterView()
    }
}
