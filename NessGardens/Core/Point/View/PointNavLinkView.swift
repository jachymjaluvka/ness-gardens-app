//
//  PointNavLinkView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 19.04.2023.
//

import SwiftUI

struct PointNavLinkView: View {
    var point: Point
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "mappin.circle.fill")
                .font(.title)
                .foregroundColor(.red)
            
            Text(point.wrappedName)
                .fixedSize(horizontal: false, vertical: true)
                .font(.headline)
            
            Spacer()
            
            HStack {
                if let _ = point.image {
                    Image(systemName: "photo")
                }
                
                if let _ = point.summary {
                    Image(systemName: "text.bubble")
                }
                
                if let _ = point.name {
                    Image(systemName: "mic")
                }
                
            }.font(.caption)
                .foregroundColor(.blue)
        }
        
    }
}

struct PointNavLinkView_Previews: PreviewProvider {
    static var previews: some View {
        let dc = DataController()
        let point = Point(context: dc.container.viewContext)
        PointNavLinkView(point: point)
            .environmentObject(dc)
    }
}
