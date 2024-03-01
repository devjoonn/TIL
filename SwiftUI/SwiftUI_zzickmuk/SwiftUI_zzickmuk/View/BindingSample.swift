//
//  BindingSample.swift
//  SwiftUI_zzickmuk
//
//  Created by 박현준 on 2/29/24.
//

import SwiftUI

struct BindingSample: View {
    @State private var backgroundColor1: Color = .brown
    @State private var textString: String = ""
    
    var body: some View {
        ZStack {
            backgroundColor1.ignoresSafeArea()
            
            VStack {
                TextField("텍스트필드도 바인딩을 씀", text: $textString)
                ChangeColorButtonView(backgroundColor2: $backgroundColor1)
            }
        }
    }
}

struct ChangeColorButtonView: View {
    @Binding var backgroundColor2: Color
    
    var body: some View {
        Button {
            backgroundColor2 = .orange
        } label: {
            Text("배경바꾸기")
                .font(.largeTitle)
                .tint(.white)
                .padding()
                .background {
                    Color.cyan
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

#Preview {
    BindingSample()
}
