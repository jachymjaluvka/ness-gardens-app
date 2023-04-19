//
//  RecordHeaderView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 13.04.2023.
//

import SwiftUI

struct RecordHeaderView: View {
    @EnvironmentObject var recordVM: RecordViewModel
    
    var body: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 10){
                Text("Active Time:")
                Text("Distance:")
            }
            .font(.title)
            VStack(alignment: .leading, spacing: 10){
                Text(recordVM.timeStringRepresentaion)
                Text(String(format: "%.3f km", recordVM.distance/1000))
            }
            .font(.title)
            .bold()
        }
    }
}

struct RecordHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        RecordHeaderView()
            .environmentObject(RecordViewModel(lm: LocationManager()))
    }
}
