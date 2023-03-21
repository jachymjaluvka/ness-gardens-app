//
//  RoutesView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 13.02.2023.
//


import SwiftUI

struct RoutesView: View {
    var routes = [Route(name: "Sefton Park Loop",
                        description: "An easy-going route which is suitable to most abilities, so a wonderful opportunity to get outdoors. A great route through Sefton Park with some hidden gems you may have previously missed even if you're a local. Great for beginnings, all the family and all ages. It can a bit busy, so choose your moment wisely and enjoy!",
                        distance: 5.6),
                  Route(name: "Route 2",
                        description: "second route",
                        distance: 10.6),
                  Route(name: "Route 3",
                        description: "third route",
                        distance: 2.6),
                  Route(name: "Route 4",
                        description: "fourth route",
                        distance: 6.6),
                  Route(name: "Route 5",
                        description: "second route",
                        distance: 10.6),
                  Route(name: "Route 6",
                        description: "third route",
                        distance: 2.6),
                  Route(name: "Route 7",
                        description: "fourth route",
                        distance: 6.6),
                  Route(name: "Route 8",
                        description: "second route",
                        distance: 10.6),
                  Route(name: "Route 9",
                        description: "third route",
                        distance: 2.6),
                  Route(name: "Route 10",
                        description: "fourth route",
                        distance: 6.6),
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
