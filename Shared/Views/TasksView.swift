//
//  TasksView.swift
//  PomodoroHub (iOS)
//
//  Created by 鈴木航 on 2020/08/07.
//

import SwiftUI

struct TasksView: View {
    @ObservedObject var activities = ActivitiesViewModel()
    
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
                        activities.isAddingNewTask = true
                    }) {
                        Image(systemName: "plus")
                    }
            ).sheet(isPresented: $activities.isAddingNewTask, onDismiss: {
                activities.isAddingNewTask = false
            }, content: {
                AddingTaskView(activities: activities)
            })
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}
