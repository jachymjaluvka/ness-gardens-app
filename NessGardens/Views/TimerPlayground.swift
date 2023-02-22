//
//  TimerPlayground.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 21.02.2023.
//

import SwiftUI

struct TimerPlayground: View {
    @State var isTimerRunning = false
    @State private var startTime =  Date()
    @State var interval = TimeInterval()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var formatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
    var body: some View {
        Text(formatter.string(from: interval) ?? "")
            .font(Font.system(.largeTitle, design: .monospaced))
            .onReceive(timer) { _ in
                if self.isTimerRunning {
                    interval = Date().timeIntervalSince(startTime)
                }
            }
             .onAppear() {
                 if !isTimerRunning {
                     startTime = Date()
                 }
                 isTimerRunning.toggle()
             }
    }
}

struct TimerPlayground_Previews: PreviewProvider {
    static var previews: some View {
        TimerPlayground()
    }
}
