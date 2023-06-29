//
//  CounterFeature.swift
//  GreenField
//
//  Created by Woojin Lee on 2023/06/21.
//

import Foundation
import ComposableArchitecture

struct CounterFeature: ReducerProtocol {
    struct State: Equatable {
        /// 카운터 숫자 상태
        var count = 0
        
        /// fact 값
        var fact: String?
        
        /// 로딩 여부
        var isLoading = false
        
        var isTimerRunning = false
    }
    
    enum Action: Equatable {
        /// 버튼 탭: 카운트 증가
        case incrementButtonTapped
        
        /// 버튼 탭: 카운트 감소
        case decrementButtonTapped
        
        /// 버튼 탭: 초기화
        case clearButtonTapped
        
        /// 버튼 탭: fact
        case factButtonTapped
        
        case factResponse(String)
        
        case timerTick
        case toggleTimerButtonTapped
    }
    
    enum CancelID { case timer }
    
    @Dependency(\.numberFact) var numberFact
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .incrementButtonTapped:
            state.count += 1
            state.fact = nil
            return .none
            
        case .decrementButtonTapped:
            state.count -= 1
            state.fact = nil
            return .none
            
        case .clearButtonTapped:
            state.count = 0
            state.fact = nil
            return .none
            
        case .factButtonTapped:
            state.fact = nil
            state.isLoading = true
            return .run { [count = state.count] send in
                try await send(.factResponse(self.numberFact.fetch(count)))
            }
            
        case .factResponse(let fact):
            state.fact = fact
            state.isLoading = false
            return .none
            
        case .timerTick:
            state.count += 1
            state.fact = nil
            return .none
            
        case .toggleTimerButtonTapped:
            state.isTimerRunning.toggle()
            if state.isTimerRunning {
                return .run { send in
                    while true {
                        try await Task.sleep(nanoseconds:  UInt64(1 * Double(NSEC_PER_SEC)))
                        await send(.timerTick)
                    }
                }
                .cancellable(id: CancelID.timer)
            } else {
                return .cancel(id: CancelID.timer)
            }
        }
    }
}
