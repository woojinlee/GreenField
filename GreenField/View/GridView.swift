//
//  GridView.swift
//  GreenField
//
//  Created by Woojin Lee on 2023/06/21.
//

import SwiftUI
import ComposableArchitecture

struct GridView: View {
    let store: StoreOf<GridFeature>
    let columns: [GridItem] = Array(repeating: .init(.adaptive(minimum: 100)), count: 2)
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }, content: { viewStore in
            NavigationStack {
                GeometryReader { proxy in
                    ScrollView {
                        LazyVGrid(columns: columns, alignment: .center, spacing: 8) {
                            ForEach(viewStore.items.map({ $0.color }), id: \.self) { color in
                                color
                                    .cornerRadius(8)
                                    .frame(height: proxy.size.width / 2)
                            }
                        }
                        .padding(8.0)
                    }
                    .navigationTitle("Grid")
                }
            }
        })
        
    }
}

struct GridViewPreviews: PreviewProvider {
    static var previews: some View {
        GridView(
            store: Store(initialState: GridFeature.State()) {
                GridFeature()
            }
        )
    }
}
