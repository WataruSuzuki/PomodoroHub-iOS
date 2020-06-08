//
//  ActivitiesViewModel.swift
//  PomodoroHub (iOS)
//
//  Created by 鈴木航 on 2020/08/08.
//

import Foundation
import Combine

class ActivitiesViewModel: ObservableObject {
    @Published var sessions: [Session] = ActivitiesModel.shared.allSessions()
    @Published var tasks: [Task] = ActivitiesModel.shared.allTasks()
    
    private var activeSession: Session?
    
    func startSession(task: TaskViewModel) {
        guard let existTask = validate(task: task) else {
            return
        }
        guard activeSession == nil else {
            print("Session has already started...")
            return
        }
        let session = ActivitiesModel.shared.generateSessionObj()
        session.start = Date()
        //session.ofTask = existTask
        ActivitiesModel.shared.insert(obj: session)
        ActivitiesModel.shared.save()
        
        activeSession = session
    }
    
    func stopSession(task: TaskViewModel) {
        guard let existSession = activeSession else {
            print("No active session found...")
            return
        }
        existSession.end = Date()
        ActivitiesModel.shared.insert(obj: existSession)
        ActivitiesModel.shared.save()
        
        activeSession = nil
    }
    
    func addNewOne(task: TaskViewModel) {
        let newTask = ActivitiesModel.shared.generateTaskObj()
        newTask.title = task.title
        newTask.taskDescription = task.taskDescription
        let date = Date()
        newTask.created_at = date
        newTask.updated_at = date
        newTask.id = UUID()
        ActivitiesModel.shared.insert(obj: newTask)

        syncTasks()
    }
    
    private func syncTasks() {
        ActivitiesModel.shared.save()
        tasks = ActivitiesModel.shared.allTasks()
    }
    
    private func validate(task: TaskViewModel) -> Task? {
        guard let existTask = ActivitiesModel.shared.fetchTaskObj(id: task.id) else {
            print("Does not exist \(task.id)")
            return nil
        }
        return existTask
    }
    
    func update(task: TaskViewModel) {
        guard let existTask = validate(task: task) else {
            return
        }
        guard existTask.title != task.title
                || existTask.taskDescription != task.taskDescription else {
            print("No updating found on task information")
            return
        }
        existTask.title = task.title
        existTask.taskDescription = task.taskDescription
        existTask.updated_at = Date()
        
        syncTasks()
    }
}
