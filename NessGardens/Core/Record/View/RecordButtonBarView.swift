//
//  RecordButtonBarView.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 13.04.2023.
//

import SwiftUI

struct RecordButtonBarView: View {
    @State var showingAddRoute = false
    @State var showingAddPoint = false
    @EnvironmentObject var recordVM: RecordViewModel
    
    @State private var showPauseButton: Bool = false
    
    var body: some View {
        HStack {
            Spacer()
            
            Button(action: addPoint) {
                VStack {
                    Image(systemName: "mappin.and.ellipse")
                        .resizable()
                        .frame(width: 27, height: 27)
                        .foregroundColor(.blue)
                    
                    Text("Add POI").foregroundColor(.black).bold()
                }

            }.frame(width: 100, height: 50)
            
            if showPauseButton {
                Button(action: pauseRecording) {
                    VStack {
                        Image(systemName: "pause.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.orange)
                        
                        Text("Pause").foregroundColor(.black).bold()
                    }

                }.frame(width: 100, height: 50)
            } else {
                Button(action: startRecording) {
                    VStack {
                        Image(systemName: "play.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.green)
                        
                        Text("Record").foregroundColor(.black).bold()
                    }

                }.frame(width: 100, height: 50)
            }
            
            Button(action: stop) {
                VStack {
                    Image(systemName: "stop.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.red)
                    
                    Text("Stop").foregroundColor(.black).bold()
                }

            }.frame(width: 100, height: 50)
            
            Spacer()
        }.sheet(isPresented: $showingAddRoute) {
            AddRouteView()
        }
        .sheet(isPresented: $showingAddPoint) {
            AddNewPointView(showCurrentRouteOption: true)
        }
    }
    
    func addPoint() -> Void {
        showingAddPoint = true
    }
    
    func stop() -> Void {
        if recordVM.routeCoordinates.count > 0 {
            recordVM.stopTimer()
            showingAddRoute.toggle()
        }
    }
    
    func startRecording() -> Void {
        showPauseButton.toggle()
        recordVM.startTimer()
    }
    
    func pauseRecording() -> Void {
        showPauseButton.toggle()
        recordVM.stopTimer()
    }
}

struct RecordButtonBarView_Previews: PreviewProvider {
    static var previews: some View {
        RecordButtonBarView()
            .environmentObject(RecordViewModel(lm: LocationManager()))
            .environmentObject(DataController())
    }
}
