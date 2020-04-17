//
//  ActivitiesModel+Task.swift
//  PomodoroHub (iOS)
//
//  Created by 鈴木航 on 2020/08/08.
//

import Foundation
import CoreData

extension ActivitiesModel {
    func allTasks() -> [Task] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        // titleでソート
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        do {
            return try context.fetch(request) as! [Task]
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
    
    func generateTaskObj() -> Task {
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: context)!
        let task = Task(entity: entity, insertInto: nil)
        return task
    }
    
    func fetchTaskObj(id: UUID) -> Task? {
        let fetchRequest = NSFetchRequest(entityName: "Task") as NSFetchRequest<NSFetchRequestResult>
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as UUID as CVarArg)
        fetchRequest.fetchLimit = 1
                
        do {
            return try context.fetch(fetchRequest)[0] as? Task
        } catch {
            print(error)
            return nil
        }
    }
}

enum TaskType: Int, CaseIterable {
    case local,
         github
}
