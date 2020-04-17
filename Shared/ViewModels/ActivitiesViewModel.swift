//
//  ActivitiesViewModel.swift
//  PomodoroHub (iOS)
//
//  Created by 鈴木航 on 2020/08/08.
//

import Foundation
import Combine

class ActivitiesViewModel: ObservableObject {
    @Published var isAddingNewTask = false
    @Published var tasks: [Task] = ActivitiesModel.shared.allTasks()
    
    func addNewOne(task: TaskViewModel) {
        let newTask = ActivitiesModel.shared.generateTaskObj()
        newTask.title = task.title
        newTask.taskDescription = task.taskDescription
        let date = Date()
        newTask.created_at = date
        newTask.updated_at = date
        newTask.id = UUID()
        ActivitiesModel.shared.insert(obj: newTask)

        sync()
        isAddingNewTask = false
    }
    
    private func sync() {
        ActivitiesModel.shared.save()
        tasks = ActivitiesModel.shared.allTasks()
    }
    
    func update(task: TaskViewModel) {
        guard let existTask = ActivitiesModel.shared.fetchTaskObj(id: task.id) else {
            print("Does not exist \(task.id)")
            return
        }
        guard existTask.title != task.title
                || existTask.taskDescription != task.taskDescription else {
            print("No updating found on task information")
            return
        }
        existTask.title = task.title
        existTask.taskDescription = task.taskDescription
        
        sync()
    }
}
