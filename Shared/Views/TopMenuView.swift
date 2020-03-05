//
//  TopMenuView.swift
//  PomodoroHub (iOS)
//
//  Created by 鈴木航 on 2020/08/03.
//

import SwiftUI

struct TopMenuView: View {
    
    var body: some View {
        TabView {
            Text(TopMenus.tasks.describing)
                .tabItem {
                    Image(systemName: "list.number")
                    Text(TopMenus.tasks.describing.localized)
                }
            SessionView()
                .tabItem {
                    Image(systemName: "timer")
                    Text(TopMenus.session.describing.localized)
                }
            Text(TopMenus.activities.describing)
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text(TopMenus.activities.describing.localized)
                }
            Text(TopMenus.settings.describing)
                .tabItem {
                    Image(systemName: "gear")
                    Text(TopMenus.settings.describing.localized)
                }
        }
    }
}

enum TopMenus: Int, CaseIterable {
    case tasks = 0,
         session,
         activities,
         settings
    
    var describing: String {
        get {
            return String(describing: self)
        }
    }
}

struct TopMenuView_Previews: PreviewProvider {
    static var previews: some View {
        TopMenuView()
    }
}
