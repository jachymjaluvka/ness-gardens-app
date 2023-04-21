//
//  PointDetailMapAnnotationView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 21.04.2023.
//

import SwiftUI

struct PointDetailMapAnnotationView: View {
    
    var point: Point
    @State var showingEdit: Bool = false
    @EnvironmentObject var dataVM: DataController
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Description")
                        .font(.title3)
                        .padding(.top)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button("Close") {
                                    dismiss()
                                }
                            }
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("Edit", action: edit)
                            }
                        }
                        .navigationTitle(point.wrappedName)
                        .navigationBarTitleDisplayMode(.inline)
                    
                    Text(point.wrappedSummary)
                    
                    Divider()
                    
                    if let image = point.image {
                        Text("Image")
                            .font(.title3)
                        Image(uiImage: UIImage(data: image) ?? UIImage())
                            .resizable()
                            .frame(height: 250)
                    }
                    
                    Divider()
                    
                    Text("Map")
                        .font(.title3)
                    MapViewRouteRepresentable(route: [], points: [point])
                        .frame(height: 250)
                    
                    HStack {
                        Text("Latitude: \(point.latitude)")
                            .font(.footnote)
                        Spacer()
                        Text("Longitude: \(point.longitude)")
                            .font(.footnote)
                    }
                    
                    Spacer()
                    
                    HStack(alignment: .center){
                        Spacer()
                        
                        Button("Delete", role: .destructive, action: delete)
                            .buttonStyle(.borderedProminent)
                            .controlSize(.large)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(/*@START_MENU_TOKEN@*/[.top, .leading, .trailing]/*@END_MENU_TOKEN@*/)
                }
            }
        }
        .padding(.horizontal)
        .sheet(isPresented: $showingEdit) {
            EditPointView(point: point)
        }
        

    }
    
    func edit() -> Void {
        print("Editing POI!")
        showingEdit.toggle()
    }
    
    func delete() -> Void{
        dataVM.deletePoint(point: point)
        dismiss()
    }
}

struct PointDetailMapAnnotationView_Previews: PreviewProvider {
    
    static var previews: some View {
        let dc = DataController()
        let context = dc.container.viewContext
        let testPoint = Point(context: context)
        PointDetailMapAnnotationView(point: testPoint)
            .environmentObject(dc)
    }
}
