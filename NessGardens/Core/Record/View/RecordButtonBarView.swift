//
//  RecordButtonBarView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 13.04.2023.
//

import SwiftUI

struct RecordButtonBarView: View {
    
    @State var recording = false
    
    var body: some View {
        HStack {
            Spacer()
            
            Button(action: placeholder) {
                VStack {
                    Image(systemName: "mappin.and.ellipse")
                        .resizable()
                        .frame(width: 27, height: 27)
                        .foregroundColor(.blue)
                    
                    Text("Add POI").foregroundColor(.black).bold()
                }

            }.frame(width: 100, height: 50)
            
            if recording {
                Button(action: pressRecord) {
                    VStack {
                        Image(systemName: "pause.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.orange)
                        
                        Text("Pause").foregroundColor(.black).bold()
                    }

                }.frame(width: 100, height: 50)
            } else {
                Button(action: pressRecord) {
                    VStack {
                        Image(systemName: "play.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.green)
                        
                        Text("Record").foregroundColor(.black).bold()
                    }

                }.frame(width: 100, height: 50)
            }
            
            Button(action: placeholder) {
                VStack {
                    Image(systemName: "stop.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.red)
                    
                    Text("Stop").foregroundColor(.black).bold()
                }

            }.frame(width: 100, height: 50)
            
            Spacer()
        }
    }
    
    func placeholder() -> Void {
        
    }
    
    func pressRecord() -> Void {
        recording.toggle()
    }
}

struct RecordButtonBarView_Previews: PreviewProvider {
    static var previews: some View {
        RecordButtonBarView()
    }
}
