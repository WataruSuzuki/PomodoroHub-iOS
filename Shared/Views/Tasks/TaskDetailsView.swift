//
//  TaskDetailsView.swift
//  PomodoroHub (iOS)
//
//  Created by 鈴木航 on 2020/08/11.
//

import SwiftUI

struct TaskDetailsView: View {
    @Environment(\.editMode) var mode
    @ObservedObject var activities: ActivitiesViewModel
    @ObservedObject var task: TaskViewModel
    
    var body: some View {
        let isEditing = mode?.wrappedValue.isEditing ?? false
        ZStack {
            TaskInfoView(
                title: task.title,
                summaries: .constant(summaries(isEditing: isEditing)),
                details: .constant(TaskDetailsRow.allCases),
                isEditing: .constant(isEditing),
                task: task
            )
            .onReceive(mode.publisher, perform: { _ in
                if let editMode = mode?.wrappedValue, editMode == .inactive {
                    activities.update(task: task)
                }
            })
            VStack {
                Spacer()
                Button(action: {
                    
                }) {
                    Text("Start working")
                        .foregroundColor(Color.white)
                }
                .frame(minWidth: 0, maxWidth: 326)
                .padding(.all)
                .background(Color.blue)
                .cornerRadius(10.0)
                .shadow(color: .gray, radius: 3, x: 3, y: 3)
                .padding(EdgeInsets(top: 0, leading: 44, bottom: 16, trailing: 44))
            }
        }
        .navigationBarBackButtonHidden(isEditing)
        .navigationBarItems(trailing: EditButton())
    }
    
    private func summaries(isEditing: Bool) -> [TaskSummariesRow] {
        if isEditing {
            return TaskSummariesRow.allCases.filter({$0.isEditable})
        } else {
            var allSummaries = TaskSummariesRow.allCases
            allSummaries.removeFirst()
            return allSummaries
        }
    }
}


struct TaskDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailsView(
            activities: ActivitiesViewModel(),
            task: TaskViewModel()
        )
    }
}
