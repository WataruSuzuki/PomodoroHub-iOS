//
//  SessionTimerView.swift
//  PomodoroHub (iOS)
//
//  Created by 鈴木航 on 2020/08/03.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var session: SessionViewModel
    
    var body: some View {
        GeometryReader { timer in
            ZStack {
                let textSize = min(timer.size.width, timer.size.height) / 4
                Circle().stroke(Color.green)
                    .padding(.all, 10)
                Arc(startAngle: .degrees(0), endAngle: .degrees(360.0 / session.countDownTime * session.focusTime), clockwise: true)
                    .stroke(Color.green, lineWidth: 10)
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 10)
                HStack {
                    Text(formatted(time: session.focusTime, unit: .minute))
                        .font(.system(size: textSize))
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                    Text(":")
                        .font(.system(size: textSize))
                    Text(formatted(time: session.focusTime, unit: .second))
                        .font(.system(size: textSize))
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            }
        }
    }
    
    fileprivate func formatted(time: TimeInterval, unit: NSCalendar.Unit) -> String {
        let calendar = Calendar.current
        let date = Date(timeInterval: -time, since: Date())

        let components = calendar.dateComponents([.year, .day, .hour, .minute, .second], from: date, to: Date())

        switch unit {
        case .minute:
            if let minute = components.minute {
                return String(format: "%02d", minute)
            }
        case .second:
            if let second = components.second {
                return String(format: "%02d", second)
            }
        default:
            break
        }
        return "??"
    }
}

struct Arc: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool

    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment

        var path = Path()
        let size = min(rect.width, rect.height)
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: size / 2, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)

        return path
    }
}

struct SessionTimerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TimerView(session: SessionViewModel())
            TimerView(session: SessionViewModel())
                .previewLayout(
                    .fixed(
                        width: UIScreen.main.bounds.height,
                        height: UIScreen.main.bounds.width))
        }
        
    }
}
