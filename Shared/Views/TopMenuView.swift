//
//  TopMenuView.swift
//  PomodoroHub (iOS)
//
//  Created by 鈴木航 on 2020/08/03.
//

import SwiftUI

struct TopMenuView: View {
    @ObservedObject private var current = CurrentWorker()
    @ObservedObject private var router = Router()
    @ObservedObject private var activities = ActivitiesViewModel()

    var body: some View {
        TabView(selection: $router.menu) {
            Menu(
                menu: TopMenus.session,
                dependencyView: AnyView(SessionView())
            )
            Menu(
                menu: TopMenus.tasks,
                dependencyView: AnyView(TasksView())
            )
            Menu(
                menu: TopMenus.activities,
                dependencyView: AnyView(ActivitiesView())
            )
            Menu(
                menu: TopMenus.settings,
                dependencyView: AnyView(Text(TopMenus.settings.describing))
            )
        }
        .environmentObject(router)
        .environmentObject(activities)
        .environmentObject(current)
//        .environmentObject(current.session)
//        .environmentObject(current.task)
    }
}

private struct Menu: View {
    var menu: TopMenus
    var dependencyView: AnyView
    @EnvironmentObject var router: Router
    
    var body: some View {
        dependencyView.tabItem {
            Image(systemName: menu.imageName)
                .onTapGesture(perform: {
                    router.menu = menu
                })
            Text(menu.describing.localized)
        }
        .tag(menu)
    }
}

enum TopMenus: Int, CaseIterable {
    case session = 0,
         tasks,
         activities,
         settings
    
    var describing: String {
        get {
            return String(describing: self)
        }
    }
    
    var imageName: String {
        get {
            switch self {
            case .session: return "timer"
            case .tasks: return "list.number"
            case .activities: return "chart.bar"
            case .settings: return "gear"
            }
        }
    }
}

struct TopMenuView_Previews: PreviewProvider {
    static var previews: some View {
        TopMenuView()
    }
}
