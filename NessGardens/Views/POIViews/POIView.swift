//
//  POIView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 13.02.2023.
//

import SwiftUI

struct POIView: View {
    var pois = [POI(name: "Albert Dock",
                    description: "Dock located in Liverpool, with historical significance",
                    latitude: 53.4003, longitude: -2.9927,
                    image: "albert-dock"),
                POI(name: "Cavern Club",
                    description: "Club in Liverpool where the Beatles have started their career",
                    latitude: 53.403665052, longitude: -2.985662724),
                POI(name: "Liver Building",
                    description: "The Royal Liver Building is a Grade I listed building in Liverpool, England.",
                    latitude: 53.4058, longitude: 2.9958),
                POI(name: "Liverpool Cathedral",
                    description: "A historical cathedral in Liverpool, with a nice view of the city",
                    latitude: 53.391831766, longitude: -2.970496118)
    ]
    
    var body: some View {
        
        NavigationStack {
            List(pois) { poi in
                NavigationLink {
                    POIDetailView(poi: poi)
                } label: {
                    HStack {
                        Text(poi.name).bold()
                    }
                }
            }
            .navigationTitle("Points of Interest")
        }
    }
}

struct POIView_Previews: PreviewProvider {
    static var previews: some View {
        POIView()
    }
}
