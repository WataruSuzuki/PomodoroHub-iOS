//
//  SessionView.swift
//  PomodoroHub (iOS)
//
//  Created by 鈴木航 on 2020/08/03.
//

import SwiftUI

struct SessionView: View {
    @EnvironmentObject var session: SessionViewModel
    @EnvironmentObject var workingTask: TaskViewModel
    
    var body: some View {
        NavigationView {
            GeometryReader { navigation in
                if navigation.size.width > navigation.size.height {
                    HStack {
                        TimerView(session: session)
                        ControlPanelView(session: session)
                            .padding()
                    }
                } else {
                    VStack {
                        TimerView(session: session)
                        ControlPanelView(session: session)
                            .padding()
                    }
                }
            }
            .navigationBarTitle(
                workingTask.title.isEmpty
                    ? TopMenus.session.describing.localized
                    : workingTask.title
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }    
}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SessionView()
                .environmentObject(SessionViewModel())
                .environmentObject(TaskViewModel())
            SessionView()
                .previewLayout(
                    .fixed(
                        width: UIScreen.main.bounds.height,
                        height: UIScreen.main.bounds.width))
                .environmentObject(SessionViewModel())
                .environmentObject(TaskViewModel())
        }
    }
}
