//
//  RouteDetailView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 13.02.2023.
//

import SwiftUI
import MapKit

var dummyRoute = Route(name: "Sefton Park Loop",
                       description: "An easy-going route which is suitable to most abilities, so a wonderful opportunity to get outdoors. A great route through Sefton Park with some hidden gems you may have previously missed even if you're a local. Great for beginnings, all the family and all ages. It can a bit busy, so choose your moment wisely and enjoy!",
                       distance: 5.6,
                       coordinates: [(1.23234, 5.76653), (56.99876, 3.9897)])


struct RouteDetailView: View {
    var route: Route
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 53.3833318,
            longitude: -2.9333296
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.02,
            longitudeDelta: 0.02
        )
    )
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Divider()
            Text("Description")
                .padding(.horizontal)
                .navigationTitle(route.name)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    Button("Edit", action: edit)
                }
                .font(.headline)
            Text(route.description)
                .padding(.horizontal)
            
            Text("Route")
                .padding([.top, .leading, .trailing])
                .font(.headline)
            Map(coordinateRegion: $region)
                
            
            buttonTab
            
            Spacer()
        }
        
    }
    
    var buttonTab: some View {
        HStack(alignment: .center){
            Spacer()
            Button("Select", role: .none, action: edit)
                .buttonStyle(.borderedProminent)
                .fontWeight(.semibold)
            
            Button("Delete", role: .destructive, action: delete)
                .buttonStyle(.borderedProminent)
                .fontWeight(.semibold)
            Spacer()
        }
        .padding(/*@START_MENU_TOKEN@*/[.top, .leading, .trailing]/*@END_MENU_TOKEN@*/)
    }
    
    func edit() -> Void {
        print("Editing POI!")
    }
    
    func delete() -> Void{
        print("Deleteing POI!")
    }
}

struct RouteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RouteDetailView(route: dummyRoute)
    }
}

