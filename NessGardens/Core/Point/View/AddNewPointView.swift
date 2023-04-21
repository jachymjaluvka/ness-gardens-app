//
//  AddPointView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 17.02.2023.
//

import PhotosUI
import SwiftUI

struct AddNewPointView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var description = ""
    @State private var longitute = ""
    @State private var latitude = ""
    
    @State var showingPicker = false
    @State var image: Image?
    @State var inputImage: UIImage?
    
    @EnvironmentObject var dataVM: DataController
    @EnvironmentObject var recordVM: RecordViewModel
    @StateObject var locationManager = LocationManager()
    @State private var selectedRoute: Route? = nil
    
    var showCurrentRouteOption: Bool
    
    var body: some View {
        
        NavigationView {
            Form {
                Section("Name") {
                    TextField("Name", text: $name)
                }
                
                Section("Description") {
                    TextEditor(text: $description)
                }
                
                image?
                    .resizable()
                    .frame(height: 200)
                
                Button("Choose Image") {
                    showingPicker = true
                }
                
                Section("Location"){
                    TextField("Latitude", text: $latitude)
                    TextField("Longitude", text: $longitute)
                    Button("Use current location", action: useCurrentLocation)
                }
                
                Section(header: Text("Route")) {
                    Picker(selection: $selectedRoute, label: Text("Routes")) {
                        if showCurrentRouteOption {
                            Text("Current Route").tag(nil as Route?)
                        } else {
                            Text("No Route").tag(nil as Route?)
                        }
                        ForEach(dataVM.allRoutes) { (route: Route) in
                            Text(route.wrappedName).tag(route as Route?)
                        }
                    }
                }
                
                HStack {
                    Spacer()
                    Button("Save", action: save)
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .fontWeight(.semibold)
                    Button("Reset", action: reset)
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .fontWeight(.semibold)
                        .tint(Color.gray)
                    Spacer()
                }
            
            }
            .navigationTitle("Add Point")
            .toolbar {
                ToolbarItem(placement: .automatic){
                    Button("Close", action: close)
                }
            }
            .sheet(isPresented: $showingPicker){
                ImagePicker(image: $inputImage)
            }
            .onChange(of: inputImage) { _ in
                loadImage()
            }
        }
    }
    
    func useCurrentLocation() -> Void {
        latitude = String(Float(locationManager.location?.latitude ?? 0))
        longitute = String(Float(locationManager.location?.longitude ?? 0))
    }
    
    func close() -> Void {
        dismiss()
    }
    
    func save() -> Void {
        
        if showCurrentRouteOption && selectedRoute == nil{
            let newPoint = Point(context: dataVM.container.viewContext)
            newPoint.id = UUID()
            newPoint.name = name
            newPoint.summary = description
            newPoint.latitude = Float(latitude) ?? 0
            newPoint.longitude = Float(longitute) ?? 0
            newPoint.route = selectedRoute
            newPoint.image = inputImage?.pngData() ?? nil
            
            recordVM.routePoints.append(newPoint)
        } else {
            dataVM.addNewPoint(name: name,
                               summary: description,
                               latitude: Float(latitude) ?? 0,
                               longitude: Float(longitute) ?? 0,
                               route: selectedRoute,
                               image: inputImage?.pngData() ?? nil
            )
        }
        
        dismiss()
    }
    
    func reset() -> Void {
        selectedRoute = nil
    }
    
    func loadImage() -> Void {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }

}

struct AddNewPOIView_Previews: PreviewProvider {
    static var previews: some View {
        let dc = DataController()
        AddNewPointView(showCurrentRouteOption: false)
            .environmentObject(dc)
            .environmentObject(RecordViewModel(lm: LocationManager()))
    }
}
