//
//  RoutesView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 13.02.2023.
//


import SwiftUI

struct RoutesView: View {
    @EnvironmentObject var dataVM: DataController
    
    @State private var showingFilter = false
    @State var sortedBy: RouteSortOption = .name
    
    var body: some View {
        NavigationStack {
            List(dataVM.filteredRoutes) { route in
                NavigationLink {
                    RouteDetailView(route: route, routePoints: route.pointsArray)
                } label: {
                    RouteNavLinkView(route: route, routePoints: route.pointsArray)
                }
            }
            .navigationTitle("Routes")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Filter") {
                        showingFilter.toggle()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Picker("Sort by: ", selection: $sortedBy.onChange(sortRoutes)) {
                        ForEach(RouteSortOption.allCases, id: \.self) { option in
                            Text("Sorted by: " + String(describing: option))
                        }
                    }.pickerStyle(.automatic)
                    
                }
            }
        }
        .sheet(isPresented: $showingFilter) {
            RouteFilterView(options: dataVM.routeFilterOptions)
        }

    }
    
    func sortRoutes(to value: RouteSortOption) -> Void {
        dataVM.sortRoutes(by: sortedBy)
    }
}

struct RoutesView_Previews: PreviewProvider {
    static var previews: some View {
        let dc = DataController()
        RoutesView()
            .environmentObject(dc)
    }
}
