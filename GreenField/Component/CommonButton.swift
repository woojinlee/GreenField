//
//  CommonButton.swift
//  GreenField
//
//  Created by Woojin Lee on 2023/06/21.
//

import SwiftUI

struct CommonButton: View {
    let title: any StringProtocol
    let action: () -> Void
    
    var body: some View {
        Button(title, action: action)
            .font(.largeTitle)
            .padding()
            .background(Color.black.opacity(0.1))
            .cornerRadius(10)
    }
}

#Preview {
    CommonButton(title: "테스트 버튼", action: {
        print("버튼 클릭")
    })
}
