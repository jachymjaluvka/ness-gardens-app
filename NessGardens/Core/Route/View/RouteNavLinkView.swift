//
//  RouteNavLinkView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 18.04.2023.
//

import SwiftUI

struct RouteNavLinkView: View {
    var route: Route
    
    var body: some View {
        HStack(spacing: 10) {
            switch route.getTypeEnum() {
            case .exercise:
                Image(systemName: "figure.run")
                    .font(.title)
            case .exploration:
                Image(systemName: "binoculars")
                    .font(.title)
            case .informative:
                Image(systemName: "book.fill")
                    .font(.title)
            case .leisure:
                Image(systemName: "figure.walk")
                    .font(.title)
            }
            VStack(alignment: .leading, spacing: 5) {
                Text(route.wrappedName)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.headline)
                HStack {
                    Text(route.wrappedDifficulty)
                        .foregroundColor(.green)
                    Divider()
                    if route.accessible {
                        Image(systemName: "figure.roll")
                            .foregroundColor(.blue)
                        Divider()
                    }
                    Text("\(route.pointsArray.count) POIs")
                }
                .font(.caption)
                .frame(height: 10)
            }
            Spacer()
            Divider()
            VStack(alignment: .trailing, spacing: 5) {
                Text(String(format: "%.2f km", route.distance/1000))
                    .font(.headline)
            }
        }
        .frame(height: 45)
    }
}

struct RouteNavLinkView_Previews: PreviewProvider {
    static var previews: some View {
        let dc = DataController()
        let route = Route(context: dc.container.viewContext)
        RouteNavLinkView(route: route)
    }
}
