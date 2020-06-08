//
//  SessionView.swift
//  PomodoroHub (iOS)
//
//  Created by 鈴木航 on 2020/08/03.
//

import SwiftUI

struct SessionView: View {
    @EnvironmentObject var current: CurrentWorker
    @EnvironmentObject var activities: ActivitiesViewModel
    
    var body: some View {
        NavigationView {
            GeometryReader { navigation in
                if navigation.size.width > navigation.size.height {
                    HStack {
                        TimerView(session: current.session)
                        ControlPanelView(
                            current: current,
                            session: current.session,
                            activities: activities)
                        .padding()
                    }
                } else {
                    VStack {
                        TimerView(session: current.session)
                        ControlPanelView(
                            current: current,
                            session: current.session,
                            activities: activities)
                        .padding()
                    }
                }
            }
            .navigationBarTitle(
                current.task.title.isEmpty
                    ? TopMenus.session.describing.localized
                    : current.task.title
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }    
}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SessionView()
                .environmentObject(CurrentWorker())
                .environmentObject(TaskViewModel())
            SessionView()
                .previewLayout(
                    .fixed(
                        width: UIScreen.main.bounds.height,
                        height: UIScreen.main.bounds.width))
                .environmentObject(CurrentWorker())
                .environmentObject(TaskViewModel())
        }
    }
}
