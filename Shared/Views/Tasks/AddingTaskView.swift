//
//  AddingTaskView.swift
//  PomodoroHub (iOS)
//
//  Created by 鈴木航 on 2020/08/11.
//

import SwiftUI

struct AddingTaskView: View {
    @EnvironmentObject var router: TaskRouter
    @ObservedObject var activities: ActivitiesViewModel
    @ObservedObject var newTask = TaskViewModel()
    @State private var notValidInput = false
    
    var body: some View {
        NavigationView {
            TaskInfoView(
                title: "addTask".localized,
                summaries: .constant(editableSummaries),
                details: .constant(editableDetails),
                isEditing: .constant(true), task: newTask
            )
            .alert(isPresented: $notValidInput) {
                Alert(title: Text("msg_must_input_title".localized))
            }
            .navigationBarItems(
                leading: Button(action: {
                    router.sheet = nil
                }) {
                    Image(systemName: "xmark")
                },
                trailing: Button(action: {
                    if newTask.valid {
                        activities.addNewOne(task: newTask)
                        router.sheet = nil
                    } else {
                        notValidInput = true
                    }
                }) {
                    Image(systemName: "checkmark")
                }
            )
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
