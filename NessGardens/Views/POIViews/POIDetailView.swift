//
//  POIDetailView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 17.02.2023.
//

import SwiftUI

let testPOI = POI(name: "Albert Dock", description: "The Royal Albert Dock is a complex of dock buildings and warehouses in Liverpool, England. Designed by Jesse Hartley and Philip Hardwick, it was opened in 1846, and was the first structure in Britain to be built from cast iron, brick and stone, with no structural wood. As a result, it was the first non-combustible warehouse system in the world. It was known simply as the Albert Dock until 2018, when it was granted a royal charter and had the honorific \"Royal\" added to its name.\n", latitude: 12.9876, longitude: 3.14159, image: "albert-dock")

struct POIDetailView: View {
    var poi: POI
    
    var body: some View {
        VStack(alignment: .leading) {
            
            if poi.imagePath != nil {
                Image(poi.imagePath!)
                    .resizable()
                    .scaledToFit()
            }
            Text("Description")
                .padding([.top, .leading, .trailing])
                .navigationTitle(poi.name)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    Button("Edit", action: edit)
                }
                .font(.headline)
            
            Text(poi.description).padding(.horizontal)
                
                
                
            
            HStack {
                Text("Latitude: \(poi.coordinates.0)")
                    .font(.footnote)
                Text("Longitude: \(poi.coordinates.1)")
                    .font(.footnote)
            }.padding(.horizontal)
            
            
            Spacer()
            
            buttonTab
        }
    }
    
    var buttonTab: some View {
        HStack(alignment: .center){
            Spacer()
            Button("Edit", role: .none, action: edit)
                .buttonStyle(.borderedProminent)
                .fontWeight(.semibold)
            
            Button("Delete", role: .destructive, action: delete)
                .buttonStyle(.borderedProminent)
                .fontWeight(.semibold)
            Spacer()
        }
        .padding(/*@START_MENU_TOKEN@*/[.top, .leading, .trailing]/*@END_MENU_TOKEN@*/)
    }
    
    func edit() -> Void {
        print("Editing POI!")
    }
    
    func delete() -> Void{
        print("Deleteing POI!")
    }
}

struct POIDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        POIDetailView(poi: testPOI)
    }
}
