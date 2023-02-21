//
//  RouteDetailView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 13.02.2023.
//

import SwiftUI

var dummyRoute = Route(name: "dummy route", description: "lorem ipsum", distance: 10.56)


struct RouteDetailView: View {
    var route: Route
    
    var body: some View {
        Text(route.description)
    }
}

struct RouteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RouteDetailView(route: dummyRoute)
    }
}

