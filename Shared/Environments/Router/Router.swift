//
//  Router.swift
//  PomodoroHub (iOS)
//
//  Created by 鈴木航 on 2020/09/25.
//

import Foundation
import Combine

class Router: ObservableObject {
    @Published var menu = TopMenus.session
}
