//
//  SessionViewModel.swift
//  PomodoroHub (iOS)
//
//  Created by 鈴木航 on 2020/08/05.
//

import Foundation
import Combine

class SessionViewModel: ObservableObject {
    @Published var countDown = pomodoroTechFocusTime
    @Published var phase = SessionPhase.firstFocus
    @Published var state = SessionState.idle {
        didSet {
            if state == .complete, let nextPhase = SessionPhase(rawValue: phase.rawValue + 1) {
                phase = nextPhase
                state = .idle
                countDown = countDownTime(phase: nextPhase)
                reviewing = true
            }
        }
    }
    @Published var reviewing = false
    @Published var interruption = false
    private lazy var timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
        guard self.state == .play && !self.interruption else { return }
        
        self.countDown -= 1.0
        if self.countDown <= 0.0 {
            self.state = .complete
        }
    }
    
    init() {
        timer.fire()
    }
    
    func countDownTime() -> Double {
        return countDownTime(phase: phase)
    }
    
    private func countDownTime(phase: SessionPhase) -> Double {
        return phase.rawValue / 2 == 0 ? pomodoroTechShortBreakTime : pomodoroTechFocusTime
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
