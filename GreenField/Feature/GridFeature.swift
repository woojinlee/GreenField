//
//  GridFeature.swift
//  GreenField
//
//  Created by Woojin Lee on 2023/06/21.
//

import ComposableArchitecture
import SwiftUI

struct GridFeature: ReducerProtocol {
    struct Item: Equatable {
        let color: Color
    }
    
    struct State: Equatable {
        var items: [Item] = [
            Item(color: Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1)))
        ]
    }
    
    enum Action: Equatable {
        // TODO: ...
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        // TODO: ...
    }
}
