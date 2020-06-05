//
//  TasksView.swift
//  PomodoroHub (iOS)
//
//  Created by 鈴木航 on 2020/08/07.
//

import SwiftUI

struct TasksView: View {
    @ObservedObject var activities = ActivitiesViewModel()
    @ObservedObject var router = TaskRouter()

    var body: some View {
        NavigationView {
            List {
                ForEach(self.activities.tasks) { task in
                    let viewModel = TaskViewModel(task: task)
                    let destination = TaskDetailsView(activities: activities, task: viewModel)
                    NavigationLink(destination: destination) {
                        Text(viewModel.title)
                    }
                }
            }
            .navigationBarTitle(TopMenus.tasks.describing.localized)
            .navigationBarItems(
                trailing:
                    Button(action: {
                        router.sheet = .addingNewTask
                    }) {
                        Image(systemName: "plus")
                    }
            ).sheet(item: $router.sheet) { item in
                switch item {
                case .addingNewTask:
                    AddingTaskView(activities: activities)
                        .environmentObject(router)
                }
            }
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView().environmentObject(TaskRouter())
    }
}
