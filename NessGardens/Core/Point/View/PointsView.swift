//
//  PointsView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 13.02.2023.
//

import SwiftUI

struct PointsView: View {
    @State private var showingAddPOI = false
    @EnvironmentObject var dataVM: DataController
    @State var showAlert: Bool = false
    @State var queryString = ""
    
    var body: some View {
        
        NavigationView {
            if dataVM.allPoints.count > 0 {
                List(searchResults) { point in
                    NavigationLink {
                        PointDetailView(point: point)
                    } label: {
                        PointNavLinkView(point: point)
                    }
                }
                .navigationTitle("POIs")
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
            } else {
                Text("No points of interest.")
                    .padding(.top)
                    .navigationTitle("POIs")
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
                Spacer()
            }
            
        }
        .searchable(text: $queryString)
        .sheet(isPresented: $showingAddPOI) {
            if dataVM.allRoutes.count > 0 {
                AddNewPointView(showCurrentRouteOption: false)
            } else {
                AddNewPointNoRouteView()
            }
        }
    }
    
    func close() {
        showAlert = false
    }
    
    var searchResults: [Point] {
        if queryString.isEmpty {
            return dataVM.allPoints
        } else {
            return dataVM.allPoints.filter { $0.wrappedName.contains(queryString) }
        }
    }
    
}

struct POIView_Previews: PreviewProvider {
    static var previews: some View {
        let dc = DataController()
        
        PointsView()
            .environmentObject(dc)
    }
}
