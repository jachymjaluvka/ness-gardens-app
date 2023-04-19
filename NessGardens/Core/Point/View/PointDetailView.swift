//
//  PointDetailView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 17.02.2023.
//

import SwiftUI

struct PointDetailView: View {
    var point: Point
    @State var showingEdit: Bool = false
    @EnvironmentObject var pointsVM: PointsViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text(point.wrappedName)
                .font(.title)
                .fontWeight(.semibold)
                .padding(.horizontal)
            
            Text(point.wrappedSummary)
                .fontWeight(.semibold)
                .padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
                
                
            
            HStack {
                Text("Latitude: \(point.latitude)")
                    .font(.footnote)
                Text("Longitude: \(point.longitude)")
                    .font(.footnote)
            }.padding(.horizontal)
            
            
            Spacer()
            
            HStack(alignment: .center){
                Spacer()
                Button("Edit", role: .none, action: edit)
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .fontWeight(.semibold)
                
                Button("Delete", role: .destructive, action: delete)
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(/*@START_MENU_TOKEN@*/[.top, .leading, .trailing]/*@END_MENU_TOKEN@*/)
            .sheet(isPresented: $showingEdit) {
                EditPointView(point: point)
            }
        }
    }
    
    func edit() -> Void {
        print("Editing POI!")
        showingEdit.toggle()
    }
    
    func delete() -> Void{
        pointsVM.deletePoint(point: point)
        dismiss()
    }
}

struct POIDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        let dc = DataController()
        
        let context = dc.container.viewContext
        let testPoint = Point(context: context)
        
        PointDetailView(point: testPoint)
            .environmentObject(RoutesViewModel(dataController: dc))
            .environmentObject(PointsViewModel(dataController: dc))
    }
}
