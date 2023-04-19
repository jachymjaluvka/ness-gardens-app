//
//  RoutesView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 13.02.2023.
//


import SwiftUI

struct RoutesView: View {
    @EnvironmentObject var routesViewModel: RoutesViewModel
    
    @State private var showingFilter = false
    
    var body: some View {
        NavigationStack {
            List(routesViewModel.allRoutes) { route in
                NavigationLink {
                    RouteDetailView(route: route)
                } label: {
                    RouteNavLinkView(route: route)
                }
            }
            .navigationTitle("Routes")
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button("Filter") {
                        showingFilter.toggle()
                    }
                }
            }
        }
        .sheet(isPresented: $showingFilter) {
            RouteFilterView()
        }

    }
}

struct RoutesView_Previews: PreviewProvider {
    static var previews: some View {
        let dc = DataController()
        RoutesView()
            .environmentObject(RoutesViewModel(dataController: dc))
    }
}
