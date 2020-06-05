//
//  CurrentWorker.swift
//  PomodoroHub (iOS)
//
//  Created by 鈴木航 on 2020/09/25.
//

import Foundation
import Combine

class CurrentWorker: ObservableObject {
    @Published var task = TaskViewModel()
    @Published var session = SessionViewModel()
    @Published var title = ""
}
