//
//  SessionControlPanelView.swift
//  PomodoroHub (iOS)
//
//  Created by 鈴木航 on 2020/08/03.
//

import SwiftUI

struct ControlPanelView: View {
    @ObservedObject var viewModel: SessionViewModel
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                viewModel.interruption = true
            }, label: {
                Image(systemName: "xmark.circle")
                    .resizable()
                    .frame(width: 44, height: 44, alignment: .center)
                    .foregroundColor(.red)
            })
            .alert(isPresented: $viewModel.interruption) {
                Alert(title: Text("caution".localized),
                      message: Text("msg_confirm_interruption".localized),
                      primaryButton: .cancel(
                        Text("cancel".localized), action: {
                            viewModel.interruption = false
                        }),
                      secondaryButton: .destructive(
                        Text("interruption".localized), action: {
                            viewModel.interruption = false
                        }))
            }
            Spacer()
            Button(action: {
                viewModel.state = viewModel.state == .play
                    ? .pause
                    : .play
            }, label: {
                Image(systemName: viewModel.state == .play
                        ? "pause.circle"
                        : "play.circle")
                    .resizable()
                    .frame(width: 44, height: 44, alignment: .center)
                    .foregroundColor(.orange)
            })
            Spacer()
            Button(action: {
                viewModel.state = .complete
            }, label: {
                Image(systemName: "checkmark.circle")
                    .resizable()
                    .frame(width: 44, height: 44, alignment: .center)
                    .foregroundColor(.green)
            })
            .sheet(isPresented: $viewModel.reviewing, onDismiss: {}, content: {
                ReviewingView(viewModel: viewModel)
            })
            Spacer()
        }
        .padding(.all, 10)
        .cornerRadius(30)
    }
}

struct SessionControlPanelView_Previews: PreviewProvider {
    static var previews: some View {
        ControlPanelView(viewModel: SessionViewModel())
    }
}
