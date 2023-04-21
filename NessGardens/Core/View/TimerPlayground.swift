//
//  TimerPlayground.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 21.02.2023.
//

import SwiftUI
import CoreData
import PhotosUI

struct TimerPlayground: View {
    
    @EnvironmentObject var dataVM: DataController
    @State var pointName = ""
    @State var selectedRoute: Route? = nil
    
    var body: some View {
        VStack {
            List {
                ForEach(dataVM.allRoutes, id: \.self) { route in
                    Section(route.wrappedName) {
                        ForEach(route.pointsArray, id: \.self) { point in
                            VStack {
                                Text(point.wrappedName)
                                if let image = point.image {
                                    Image(uiImage: UIImage(data: image)!)
                                }
                            }
                            
                        }
                    }
                }
            }
            
            Picker(selection: $selectedRoute, label: Text("Route")) {
                Text("No Route").tag(nil as Route?)
                ForEach(dataVM.allRoutes) { (route: Route) in
                    Text(route.wrappedName).tag(route as Route?)
                }
            }
            
            TextField("Point Name", text: $pointName)
                .padding(.horizontal)
            
            Button("Add Point", action: addPoint)
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .fontWeight(.semibold)
            
            Button("Add Route", action: addRoute)
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .fontWeight(.semibold)
        }
    }
    
    func addPoint() -> Void {
        dataVM.addNewPoint(name: pointName, summary: "", latitude: 0, longitude: 0, route: selectedRoute)
    }
    
    func addRoute() -> Void {
        let route1 = Route(context: dataVM.container.viewContext)
        route1.name = "Route 1"
        route1.summary = "some summary"
        route1.id = UUID()
        route1.accessible = false
        route1.coordinates = []
        route1.difficulty = "Easy"
        route1.type = "Excercise"
        
        let route2 = Route(context: dataVM.container.viewContext)
        route2.name = "Route 2"
        route2.summary = "some summary"
        route2.id = UUID()
        route2.accessible = false
        route2.coordinates = []
        route2.difficulty = "Easy"
        route2.type = "Excercise"
        
        dataVM.save()
    }

}

struct TimerPlayground_Previews: PreviewProvider {
    static var previews: some View {
        let dc = DataController()
        TimerPlayground()
            .environmentObject(dc)
    }
}
