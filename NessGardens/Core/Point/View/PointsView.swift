//
//  PointsView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 13.02.2023.
//

import SwiftUI

struct PointsView: View {
    @State private var showingAddPOI = false
    @EnvironmentObject var pointsViewModel: PointsViewModel
    @EnvironmentObject var routesViewModel: RoutesViewModel
    @State var showAlert: Bool = false
    
    var body: some View {
        
        NavigationStack {
            if pointsViewModel.allPoints.count > 0 {
                List(pointsViewModel.allPoints) { point in
                    NavigationLink {
                        PointDetailView(point: point)
                    } label: {
                        HStack {
                            Text(point.wrappedName).bold()
                        }
                    }
                }
                .navigationTitle("Points of Interest")
                .toolbar {
                    if routesViewModel.allRoutes.count > 0 {
                        ToolbarItem(placement: .automatic) {
                            Image(systemName: "plus")
                                .foregroundColor(.blue)
                                .bold()
                                .onTapGesture {
                                    showingAddPOI.toggle()
                                }
                        }
                    }
                }
            } else {
                Text("No points of interest.")
                    .padding(.top)
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
                Spacer()
            }
            
        }
        .sheet(isPresented: $showingAddPOI) {
            if routesViewModel.allRoutes.count > 0 {
                AddNewPointView(firstRoute: routesViewModel.allRoutes[0])
            } else {
                AddNewPointNoRouteView()
            }
        }
    }
    
    func close() {
        showAlert = false
    }
    
}

struct POIView_Previews: PreviewProvider {
    static var previews: some View {
        let dc = DataController()
        
        PointsView()
            .environmentObject(RoutesViewModel(dataController: dc))
            .environmentObject(PointsViewModel(dataController: dc))
    }
}
