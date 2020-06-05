//
//  TaskRouter.swift
//  PomodoroHub (iOS)
//
//  Created by 鈴木航 on 2020/09/25.
//

import Foundation
import Combine

class TaskRouter: ObservableObject {
    @Published var sheet: TaskSheet?
}

enum TaskSheet: Hashable, Identifiable {
    case addingNewTask

    var id: Int {
        return self.hashValue
    }
}
