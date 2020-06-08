//
//  SessionViewModel.swift
//  PomodoroHub (iOS)
//
//  Created by 鈴木航 on 2020/08/05.
//

import Foundation
import Combine

class SessionViewModel: ObservableObject {
    @Published var focusTime = pomodoroTechFocusTime
    @Published var phase = SessionPhase.firstFocus
    @Published var state = SessionState.idle {
        didSet {
            registerEntryPoint(state: state)
            if state == .complete, let nextPhase = SessionPhase(rawValue: phase.rawValue + 1) {
                phase = nextPhase
                state = .idle
                focusTime = countDownTime(phase: nextPhase)
                reviewing = true
            }
        }
    }
    @Published var reviewing = false
    @Published var interruption = false
    private lazy var timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
        guard self.state == .play && !self.interruption else { return }
        
        self.focusTime -= 1.0
        if self.focusTime <= 0.0 {
            self.state = .complete
        }
    }
    var countDownTime: Double {
        get { return countDownTime(phase: phase) }
    }
    
    init() {
        timer.fire()
    }
    
    private func countDownTime(phase: SessionPhase) -> Double {
        return phase.rawValue / 2 == 0 ? pomodoroTechShortBreakTime : pomodoroTechFocusTime
    }
    
    private func registerEntryPoint(state: SessionState) {
        
    }
}

enum SessionState: Hashable {
    case idle,
         play,
         pause,
         complete
}

enum SessionPhase: Int {
    case firstFocus = 0,
         firstBreak,
         secondFocus,
         secondBreak,
         thirdFocus,
         thirdBreak,
         finalFocus,
         complete
}
