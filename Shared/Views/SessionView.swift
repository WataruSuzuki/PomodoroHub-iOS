//
//  SessionView.swift
//  PomodoroHub (iOS)
//
//  Created by 鈴木航 on 2020/08/03.
//

import SwiftUI

struct SessionView: View {
    @ObservedObject var viewModel = SessionViewModel()
    
    var body: some View {
        NavigationView {
            GeometryReader { navigation in
                if navigation.size.width > navigation.size.height {
                    HStack {
                        TimerView(viewModel: viewModel)
                        ControlPanelView(viewModel: viewModel)
                            .padding()
                    }
                } else {
                    VStack {
                        TimerView(viewModel: viewModel)
                        ControlPanelView(viewModel: viewModel)
                            .padding()
                    }
                }
            }
            .navigationTitle(TopMenus.session.describing.localized)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }    
}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SessionView()
            SessionView().previewLayout(.fixed(width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.width))
        }
    }
}
