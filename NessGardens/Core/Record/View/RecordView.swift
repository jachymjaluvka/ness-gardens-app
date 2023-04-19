//
//  RecordView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 13.02.2023.
//

import SwiftUI
import MapKit

struct RecordView: View {
    @State var recording = false
    @EnvironmentObject var recordVM: RecordViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            RecordHeaderView().padding(.horizontal)
            
            Divider().padding(.horizontal)
            
            MapViewRecordRepresentable()
                .ignoresSafeArea(edges: .horizontal)
            
            Divider()
            
            RecordButtonBarView().padding(.horizontal)
            
        }
        
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
            .environmentObject(RecordViewModel(lm: LocationManager()))
    }
}
