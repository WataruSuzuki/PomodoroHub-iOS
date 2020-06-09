//
//  SessionControlPanelView.swift
//  PomodoroHub (iOS)
//
//  Created by 鈴木航 on 2020/08/03.
//

import SwiftUI

struct ControlPanelView: View {
    @ObservedObject var task: TaskViewModel
    @ObservedObject var session: SessionViewModel
    @ObservedObject var activities: ActivitiesViewModel
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                session.interruption = true
            }, label: {
                Image(systemName: "xmark.circle")
                    .resizable()
                    .frame(width: 44, height: 44, alignment: .center)
                    .foregroundColor(.red)
            })
            .alert(isPresented: $session.interruption) {
                Alert(title: Text("caution".localized),
                      message: Text("msg_confirm_interruption".localized),
                      primaryButton: .cancel(
                        Text("cancel".localized), action: {
                            session.interruption = false
                        }),
                      secondaryButton: .destructive(
                        Text("interruption".localized), action: {
                            session.interruption = false
                        }))
            }
            Spacer()
            Button(action: {
                if session.state == .play {
                    session.state = .pause
                    //activities.stopSession(task: )
                } else {
                    session.state = .play
                }
            }, label: {
                Image(systemName: session.state == .play
                        ? "pause.circle"
                        : "play.circle")
                    .resizable()
                    .frame(width: 44, height: 44, alignment: .center)
                    .foregroundColor(.orange)
            })
            Spacer()
            Button(action: {
                session.state = .complete
            }, label: {
                Image(systemName: "checkmark.circle")
                    .resizable()
                    .frame(width: 44, height: 44, alignment: .center)
                    .foregroundColor(.green)
            })
            .sheet(isPresented: $session.reviewing, onDismiss: {}, content: {
                ReviewingView(viewModel: session)
            })
            Spacer()
        }
        .padding(.all, 10)
        .cornerRadius(30)
    }
}

struct SessionControlPanelView_Previews: PreviewProvider {
    static var previews: some View {
        ControlPanelView(
            task: TaskViewModel(),
            session: SessionViewModel(),
            activities: ActivitiesViewModel()
        )
    }
}
