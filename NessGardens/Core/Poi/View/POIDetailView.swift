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
    @State var showingEdit: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text(poi.name)
                .font(.title)
                .fontWeight(.semibold)
                .padding(.horizontal)
            
            if poi.imagePath != nil {
                Image(poi.imagePath!)
                    .resizable()
                    .scaledToFit()
            }
            
            Text(poi.description)
                .fontWeight(.semibold)
                .padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
                
                
            
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
                .controlSize(.large)
                .fontWeight(.semibold)
            
            Button("Delete", role: .destructive, action: delete)
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .fontWeight(.semibold)
            Spacer()
        }
        .padding(/*@START_MENU_TOKEN@*/[.top, .leading, .trailing]/*@END_MENU_TOKEN@*/)
        .fullScreenCover(isPresented: $showingEdit) {
            EditPOIView(poi: poi)
        }
    }
    
    func edit() -> Void {
        print("Editing POI!")
        showingEdit.toggle()
    }
    
    func delete() -> Void{
        print("Deleteing POI!")
    }
}

struct POIDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        POIDetailView(poi: testPOI)
            .environmentObject(RoutesViewModel())
    }
}
