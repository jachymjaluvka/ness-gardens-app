//
//  POIView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 13.02.2023.
//

import SwiftUI

struct POIView: View {
    @State private var showingAddPOI = false
    @EnvironmentObject var pointsViewModel: POIViewModel
    
    var body: some View {
        
        NavigationStack {
            List(pointsViewModel.allPoints) { poi in
                NavigationLink {
                    POIDetailView(poi: poi)
                } label: {
                    HStack {
                        Text(poi.name).bold()
                    }
                }
            }
            .navigationTitle("Points of Interest")
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Image(systemName: "plus")
                        .foregroundColor(.blue)
                        .bold()
                        .onTapGesture {
                            showingAddPOI.toggle()
                        }
                }
            }
        }.sheet(isPresented: $showingAddPOI) {
            AddNewPOIView()
        }
    }
    
}

struct POIView_Previews: PreviewProvider {
    static var previews: some View {
        POIView()
            .environmentObject(RoutesViewModel())
            .environmentObject(POIViewModel())
    }
}
