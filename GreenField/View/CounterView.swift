//
//  CounterView.swift
//  GreenField
//
//  Created by Woojin Lee on 2023/06/21.
//

import SwiftUI
import ComposableArchitecture

struct CounterView: View {
    let store: StoreOf<CounterFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Text("\(viewStore.count)")
                    .font(.largeTitle)
                    .padding()
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
                HStack {
                    CommonButton(title: "-") {
                        viewStore.send(.decrementButtonTapped)
                    }
                    CommonButton(title: "+") {
                        viewStore.send(.incrementButtonTapped)
                    }
                }
                
                CommonButton(title: "Clear") {
                    viewStore.send(.clearButtonTapped)
                }
                
                CommonButton(title: viewStore.isTimerRunning ? "Stop timer" : "Start timer") {
                    viewStore.send(.toggleTimerButtonTapped)
                }
                
                CommonButton(title: "Fact") {
                    viewStore.send(.factButtonTapped)
                }
                
                if viewStore.isLoading {
                    ProgressView()
                } else if let fact = viewStore.fact {
                    Text(fact)
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
        }
    }
}

#Preview {
    CounterView(
        store: .init(initialState: CounterFeature.State()) {
            CounterFeature()
        }
    )
}
