//
//  AddingTaskView.swift
//  PomodoroHub (iOS)
//
//  Created by 鈴木航 on 2020/08/11.
//

import SwiftUI

struct AddingTaskView: View {
    @ObservedObject var activities: ActivitiesViewModel
    @ObservedObject var newTask = TaskViewModel()
    
    var body: some View {
        NavigationView {
            TaskInfoView(
                title: "addTask".localized,
                summaries: .constant(editableSummaries),
                details: .constant(editableDetails),
                isEditing: .constant(true), task: newTask
            )
            .navigationBarItems(
                    leading: Button(action: {
                        activities.isAddingNewTask = false
                    }) {
                        Image(systemName: "xmark")
                    },
                    trailing: Button(action: {
                        activities.addNewOne(task: newTask)
                    }) {
                        Image(systemName: "checkmark")
                    })
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    private var editableSummaries: [TaskSummariesRow] {
        return TaskSummariesRow.allCases.filter({$0.isEditable})
    }
    
    private var editableDetails: [TaskDetailsRow] {
        return TaskDetailsRow.allCases.filter({$0.isEditable})
    }
}

struct AddingTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddingTaskView(activities: ActivitiesViewModel())
    }
}
