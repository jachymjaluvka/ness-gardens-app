//
//  TimerPlayground.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 21.02.2023.
//

import SwiftUI

struct TimerPlayground: View {
    
    @EnvironmentObject var dataVM: DataController
    
    @State var routes: [Route] = []
    
    var body: some View {
        VStack {
            Text("Routes")
            List {
                ForEach(routes, id: \.self) { route in
                    Section(route.wrappedName) {
                        ForEach(dataVM.fetchRoutePoints(route: route), id: \.self) { point in
                            Text(point.wrappedName)
                        }
                    }
                }
            }
        }.padding(.horizontal)
            .onAppear(perform: loadRoutes)
    }
    
    func loadRoutes() -> Void {
        routes = dataVM.fetchRoutes()
    }
}

struct TimerPlayground_Previews: PreviewProvider {
    static var previews: some View {
        let dc = DataController()
        TimerPlayground()
            .environmentObject(dc)
    }
}
