//
//  RecordHeaderView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 13.04.2023.
//

import SwiftUI

struct RecordHeaderView: View {
    var body: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 10){
                Text("Active Time:")
                Text("Distance:")
            }
            .font(.title)
            VStack(alignment: .trailing, spacing: 10){
                Text("01:45:00")
                Text("12.56 km")
            }
            .font(.title)
            .bold()
        }
    }
}

struct RecordHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        RecordHeaderView()
    }
}
