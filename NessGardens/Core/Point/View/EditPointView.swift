//
//  EditPointView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 13.04.2023.
//

import SwiftUI

struct EditPointView: View {
    @Environment(\.dismiss) var dismiss
    
    public var point: Point
    
    @State private var name: String
    @State private var description: String
    @State private var longitute: String
    @State private var latitude: String
    
    @State var showingPicker = false
    @State var image: Image?
    @State var inputImage: UIImage?
    
    @EnvironmentObject var dataVM: DataController
    @State var selectedRoute: Route?
    @StateObject var locationManager = LocationManager()
    
    init(point: Point) {
        self.point = point
        _name = State(initialValue: point.wrappedName)
        _description = State(initialValue: point.wrappedSummary)
        _latitude = State(initialValue: String(point.latitude))
        _longitute = State(initialValue: String(point.longitude))
        _selectedRoute = State(initialValue: point.route)
    }
    
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
                    TextField("Longitude", text: $longitute)
                    TextField("Latitude", text: $latitude)
                    Button("Use current location", action: useCurrentLocation)
                }
                
                Section(header: Text("Route")) {
                    Picker(selection: $selectedRoute, label: Text("Routes")) {
                        Text("No Route").tag(nil as Route?)
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
            .navigationTitle("Edit - \(point.wrappedName)")
            .navigationBarTitleDisplayMode(.inline)
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
        dataVM.updatePoint(point: point,
                             name: name,
                             summary: description,
                             latitude: Float(latitude) ?? 0,
                             longitude: Float(longitute) ?? 0,
                             route: selectedRoute)
        
        dismiss()
    }
    
    func reset() -> Void {
        name = point.wrappedName
        description = point.wrappedSummary
        
        if let image = point.image {
            inputImage = UIImage(data: image) ?? UIImage()
            loadImage()
        } else {
            inputImage = nil
            image = nil
        }
        
        longitute = String(point.longitude)
        latitude = String(point.latitude)
        
        selectedRoute = point.route
    }
    
    func loadImage() -> Void {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }

}

struct EditPOIView_Previews: PreviewProvider {
    static var previews: some View {
        let dc = DataController()
        
        let context = dc.container.viewContext
        let testPoint = Point(context: context)
        
        EditPointView(point: testPoint)
            .environmentObject(dc)
    }
}
