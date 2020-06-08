//
//  TaskDetailsView.swift
//  PomodoroHub (iOS)
//
//  Created by 鈴木航 on 2020/08/11.
//

import SwiftUI

struct TaskDetailsView: View {
    @Environment(\.editMode) var mode
    @EnvironmentObject var router: Router
    @EnvironmentObject var currentWorker: CurrentWorker
    @ObservedObject var activities: ActivitiesViewModel
    @ObservedObject var task: TaskViewModel
    @State private var askOverwrite = false

    var body: some View {
        let isEditing = mode?.wrappedValue.isEditing ?? false
        ZStack {
            TaskInfoView(
                title: task.title,
                summaries: .constant(summaries(isEditing: isEditing)),
                details: .constant(TaskDetailsRow.allCases),
                isEditing: .constant(isEditing),
                task: task
            )
            .alert(isPresented: $askOverwrite, content: {
                Alert(
                    title: Text("(・A・)"),
                    message: Text("msg_interrupt_current_session".localized),
                    primaryButton: .cancel(Text("cancel".localized)),
                    secondaryButton: .destructive(Text("DoIt".localized), action: {
                        startNewSession()
                    })
                )
            })
            .onReceive(mode.publisher, perform: { _ in
                if let editMode = mode?.wrappedValue, editMode == .inactive {
                    activities.update(task: task)
                }
            })
            VStack {
                Spacer()
                Button(action: {
                    guard !currentWorker.task.valid else {
                        askOverwrite = true
                        return
                    }
                    startNewSession()
                }) {
                    Text("Start working")
                        .foregroundColor(Color.white)
                }
                .frame(minWidth: 0, maxWidth: 326)
                .padding(.all)
                .background(Color.blue)
                .cornerRadius(10.0)
                .shadow(color: .gray, radius: 3, x: 3, y: 3)
                .padding(EdgeInsets(top: 0, leading: 44, bottom: 16, trailing: 44))
            }
        }
        .navigationBarBackButtonHidden(isEditing)
        .navigationBarItems(trailing: EditButton())
    }
    
    private func summaries(isEditing: Bool) -> [TaskSummariesRow] {
        if isEditing {
            return TaskSummariesRow.allCases.filter({$0.isEditable})
        } else {
            var allSummaries = TaskSummariesRow.allCases
            allSummaries.removeFirst()
            return allSummaries
        }
    }
    
    private func startNewSession() {
        currentWorker.task = task
        
        currentWorker.session = SessionViewModel()
        currentWorker.session.state = .play
        
        activities.startSession(task: task)
        
        router.menu = TopMenus.session
    }
}


struct TaskDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailsView(
            activities: ActivitiesViewModel(),
            task: TaskViewModel()
        )
    }
}
