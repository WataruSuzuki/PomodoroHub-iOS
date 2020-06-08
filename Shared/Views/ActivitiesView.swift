//
//  ActivitiesView.swift
//  PomodoroHub (iOS)
//
//  Created by 鈴木航 on 2020/11/09.
//

import SwiftUI

struct ActivitiesView: View {
    @ObservedObject var taskRouter = TaskRouter()
    @EnvironmentObject var activities: ActivitiesViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.activities.sessions) { session in
                    let task = TaskViewModel(task: session.ofTask)
                    Text(task.title)
                }
            }
            .navigationBarTitle(TopMenus.activities.describing.localized)
        }
    }
}
