//
//  ContentView.swift
//  GreenField
//
//  Created by Woojin Lee on 2023/06/21.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    var body: some View {
        VStack() {
            Text("Counter!")
            CounterView(store: Store(initialState: CounterFeature.State()) {
                CounterFeature()
            })
        }
        .padding(8.0)
    }
}

#Preview {
    ContentView()
}
