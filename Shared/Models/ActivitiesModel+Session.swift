//
//  ActivitiesModel+Session.swift
//  PomodoroHub (iOS)
//
//  Created by 鈴木航 on 2020/11/09.
//

import Foundation
import CoreData

extension ActivitiesModel {
    func allSessions() -> [Session] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Session")
        let sortDescriptor = NSSortDescriptor(key: "start", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        do {
            return try context.fetch(request) as! [Session]
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
    
    func generateSessionObj() -> Session {
        let entity = NSEntityDescription.entity(forEntityName: "Session", in: context)!
        let task = Session(entity: entity, insertInto: nil)
        return task
    }
    
    func fetchSessionObj(id: UUID) -> Session? {
        let fetchRequest = NSFetchRequest(entityName: "Session") as NSFetchRequest<NSFetchRequestResult>
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as UUID as CVarArg)
        fetchRequest.fetchLimit = 1
                
        do {
            return try context.fetch(fetchRequest)[0] as? Session
        } catch {
            print(error)
            return nil
        }
    }
}
