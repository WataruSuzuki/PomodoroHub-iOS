//
//  TaskViewModel.swift
//  PomodoroHub (iOS)
//
//  Created by 鈴木航 on 2020/09/21.
//

import Foundation
import Combine

class TaskViewModel: ObservableObject {
    let id: UUID
    @Published var title = ""
    @Published var taskDescription = ""
    
    init(task: Task? = nil) {
        if let task = task {
            id = task.id ?? UUID()
            title = task.title ?? ""
            taskDescription = task.taskDescription ?? ""
        } else {
            id = UUID()
        }
    }
    
    private static let unknown = ""
    var valid: Bool {
        get { return !title.isEmpty }
    }
}
