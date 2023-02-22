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
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 40.83834587046632,
            longitude: 14.254053016537693
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.03,
            longitudeDelta: 0.03
        )
    )
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 20){
                Text("ACTIVE TIME:").monospaced()
                Text("01:45:00").monospaced()
            }.font(.title2)
            HStack(spacing: 20){
                Text("DISTANCE:").monospaced()
                Text("12.56 KM").monospaced()
            }.font(.title2)
            
            Map(coordinateRegion: $region)
            
            Divider()
            HStack() {
                Spacer()
                
                makeButton(action: placeholder,
                           img: "mappin.and.ellipse",
                           text: "Add POI",
                           color: .blue)
                
                Divider().frame(width: 0.1, height: 50)
                    .overlay(Color.gray)
                
                if recording {
                    makeButton(action: pauseRecording,
                               img: "pause.fill",
                               text: "Pause",
                               color: .orange)
                }else{
                    makeButton(action: startRecording,
                               img: "play.fill",
                               text: "Record",
                               color: .green)
                }
                
                Divider().frame(width: 0.1, height: 50)
                    .overlay(Color.gray)
                
                makeButton(action: placeholder, img: "stop.fill", text: "Stop", color: .red)
                
                Spacer()
                

            }
            
        }
        .padding(.all)
        
    }
    
    func makeButton(action: @escaping () -> Void,
                    img: String,
                    text: String,
                    color: Color) -> some View {
        
        return Button(action: action) {
            VStack {
                Image(systemName: img)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(color)
                
                Text(text).foregroundColor(.black).bold()
            }

        }.frame(width: 100, height: 50)
        
    }
    
    func startRecording() -> Void {
        print("Started Recording!")
        recording = true
    }
    
    func pauseRecording() -> Void {
        print("Recording Paused!")
        recording = false
    }
    
    func placeholder() -> Void {
        
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
