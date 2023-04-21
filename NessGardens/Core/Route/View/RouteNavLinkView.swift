//
//  RouteNavLinkView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 18.04.2023.
//

import SwiftUI

struct RouteNavLinkView: View {
    var route: Route
    var routePoints: [Point]
    
    @EnvironmentObject var dataVM: DataController
    
    var body: some View {
        HStack(spacing: 10) {
            switch route.typeEnum {
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
                    Text(route.difficultyEnum.rawValue)
                        .foregroundColor(difficultyColour)
                    Divider()
                    if route.accessible {
                        Image(systemName: "figure.roll")
                            .foregroundColor(.blue)
                        Divider()
                    }
                    Text("\(routePoints.count) POIs")
                }
                .font(.caption)
                .frame(height: 10)
                .fixedSize(horizontal: false, vertical: true)
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
    
    var difficultyColour: Color {
        switch route.difficultyEnum {
        case .easy:
            return Color.green
        case .medium:
            return Color.orange
        case .hard:
            return Color.red
        }
    }
}

struct RouteNavLinkView_Previews: PreviewProvider {
    static var previews: some View {
        let dc = DataController()
        let route = Route(context: dc.container.viewContext)
        RouteNavLinkView(route: route, routePoints: [])
            .environmentObject(dc)
    }
}
