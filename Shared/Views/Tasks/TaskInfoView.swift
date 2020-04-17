//
//  TaskInfoView.swift
//  PomodoroHub (iOS)
//
//  Created by 鈴木航 on 2020/08/07.
//

import SwiftUI

struct TaskInfoView: View {
    var title: String
    @Binding var summaries: [TaskSummariesRow]
    @Binding var details: [TaskDetailsRow]
    @Binding var isEditing: Bool
    @ObservedObject var task: TaskViewModel
    
    var body: some View {
        Form {
            Section {
                ForEach(summaries, id: \.self) { row in
                    switch row {
                    case .title:
                        TextFieldRow(
                            isEditing: .constant(isEditing),
                            editableText: $task.title,
                            placeHolder: row.describing)
                    default:
                        Text(row.describing)
                    }
                }
            }
            Section(header: Text("details")) {
                ForEach(details, id: \.self) { row in
                    switch row {
                    case .taskDescription:
                        TextEditorRow(
                            isEditing: .constant(isEditing),
                            editableText: $task.taskDescription,
                            placeHolder: isEditing ? row.placeHolder : row.describing)
                    }
                }
            }
        }
        .navigationBarTitle(title)
    }
}

enum TaskSummariesRow: Int, CaseIterable {
    case title,
         phase,
         deadline

    var isEditable: Bool {
        get {
            switch self {
            case .title: return true
            default: return false
            }
        }
    }
}

enum TaskDetailsRow: Int, CaseIterable {
    case taskDescription

    var isEditable: Bool {
        get {
            switch self {
            case .taskDescription: return true
            }
        }
    }
    
    var placeHolder: String {
        get {
            switch self {
            case .taskDescription: return "Leave a comment"
            }
        }
    }
}

struct TaskInfoView_Previews: PreviewProvider {
    static var previews: some View {
        TaskInfoView(title: "navigation bar title",
                     summaries: .constant(TaskSummariesRow.allCases),
                     details: .constant(TaskDetailsRow.allCases),
                     isEditing: .constant(false), task: TaskViewModel())
    }
}
