//
//  RoutesView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 13.02.2023.
//


import SwiftUI

struct RoutesView: View {
    var routes = [Route(name: "Route 1", description: "first route", distance: 5.6),
                  Route(name: "Route 2", description: "second route", distance: 10.6),
                  Route(name: "Route 3", description: "third route", distance: 2.6),
                  Route(name: "Route 4", description: "fourth route", distance: 6.6),
    ]
    
    var body: some View {
        NavigationStack {
            List(routes) { route in
                NavigationLink {
                    RouteDetailView(route: route)
                } label: {
                    HStack {
                        Text(route.name).bold()
                        var routeDistance = String(format: "- %.2f km", route.distance)
                        Text(routeDistance)
                    }
                }
            }
            .navigationTitle("Routes")
        }
    }
}

struct RoutesView_Previews: PreviewProvider {
    static var previews: some View {
        RoutesView()
    }
}
