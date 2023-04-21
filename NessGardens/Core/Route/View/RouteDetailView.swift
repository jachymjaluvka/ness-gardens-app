//
//  RouteDetailView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 13.02.2023.
//

import SwiftUI


struct RouteDetailView: View {
    @EnvironmentObject var dataVM: DataController
    @Environment(\.dismiss) var dismiss
    
    var route: Route
    var routePoints: [Point]
    var minRowHeight: CGFloat = 70
    
    @State var selectedPoint: Point? = nil
    @State var showingRouteEdit: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 5) {
                Text("Description")
                    .padding([.top, .leading, .trailing])
                    .font(.title3)
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
                        Text(route.typeEnum.rawValue)
                        Divider()
                        Text(route.difficultyEnum.rawValue)
                        Divider()
                        Text(String(format: "%.3f km", route.distance/1000))
                        Divider()
                    }
                }.padding(.horizontal)
                    .bold()
                
                Text("Points")
                    .padding([.top, .leading, .trailing])
                    .font(.headline)
                
                if routePoints.count > 0 {
                    NavigationView {
                        List {
                            ForEach(routePoints, id: \.self) { point in
                                NavigationLink{
                                    PointDetailView(point: point)
                                } label: {
                                    PointNavLinkView(point: point)
                                        .frame(width: 400)
                                }
                            }
                        }
                        .padding([.leading, .top], -35)
                    }.frame(height: minRowHeight * CGFloat(routePoints.count))
                } else {
                    Text("No points of interest in this route.")
                        .padding(.horizontal)
                }

                Divider()
                
                Text("Map")
                    .padding([.top, .leading, .trailing])
                    .font(.title3)
                MapViewRouteRepresentable(route: route.wrappedCoordinates, points: routePoints)
                    .frame(height: 400)
                
                HStack(spacing: 20) {
                    Spacer()
                    
                    if route == dataVM.selectedRoute {
                        Button("Stop Routing", action: deselect)
                            .buttonStyle(.borderedProminent)
                            .controlSize(.large)
                            .fontWeight(.semibold)
                            .tint(Color.orange)
                    } else {
                        Button("Select", action: select)
                            .buttonStyle(.borderedProminent)
                            .controlSize(.large)
                            .fontWeight(.semibold)
                    }
                    Button("Delete", role: .destructive, action: delete)
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding(.top)
            }
            .sheet(isPresented: $showingRouteEdit) {
                RouteEditView(route: route)
            }
        }
        .navigationTitle(route.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .automatic) {
                Button("Edit", action: edit)
            }
        }

    }
    
    func select() -> Void {
        dataVM.selectRoute(route: route)
    }
    
    func deselect() -> Void {
        dataVM.deselectRoute()
    }
    
    func edit() {
        showingRouteEdit = true
    }
    
    func delete() {
        dataVM.deleteRoute(route: route)
        dismiss()
    }
    
}

struct RouteDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        let dc = DataController()
        
        let context = dc.container.viewContext
        let testRoute = Route(context: context)
        
        RouteDetailView(route: testRoute, routePoints: [])
            .environmentObject(dc)
    }
}

