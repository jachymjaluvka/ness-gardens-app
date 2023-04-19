//
//  RouteDetailView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 13.02.2023.
//

import SwiftUI


struct RouteDetailView: View {
    @EnvironmentObject var routesVM: RoutesViewModel
    @Environment(\.dismiss) var dismiss
    
    var route: Route
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 5) {
                Text("Description")
                    .padding([.top, .leading, .trailing])
                    .font(.title3)
                    .navigationTitle(route.wrappedName)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar{
                        ToolbarItem(placement: .automatic) {
                            Button("Edit", action: edit)
                        }
                    }
                Text(route.wrappedSummary)
                    .padding(.horizontal)
                
                Text("Route Information")
                    .padding([.top, .leading, .trailing])
                    .font(.headline)
                
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Type: ")
                        Divider()
                        Text("Difficulty: ")
                        Divider()
                        Text("Distance: ")
                        Divider()
                    }
                    VStack(alignment: .trailing, spacing: 5) {
                        Text(route.wrappedType)
                        Divider()
                        Text(route.wrappedDifficulty)
                        Divider()
                        Text(String(format: "%.3f km", route.distance/1000))
                        Divider()
                    }
                }.padding(.horizontal)
                    .bold()

                Text("Map")
                    .padding([.top, .leading, .trailing])
                    .font(.title3)
                MapViewRouteRepresentable(route: route.wrappedCoordinates)
                    .frame(height: 400)
                
                HStack(spacing: 20) {
                    Spacer()
                    Button("Select", action: select)
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .fontWeight(.semibold)
                    Button("Delete", role: .destructive, action: delete)
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding(.top)
            }
        }
    }
    
    func edit() {
        
    }
    
    func select() {
        
    }
    
    func delete() {
        routesVM.deleteRoute(route: route)
        dismiss()
    }
    
}

struct RouteDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        let dc = DataController()
        
        let context = dc.container.viewContext
        let testRoute = Route(context: context)
        
        RouteDetailView(route: testRoute)
            .environmentObject(RoutesViewModel(dataController: dc))
    }
}

