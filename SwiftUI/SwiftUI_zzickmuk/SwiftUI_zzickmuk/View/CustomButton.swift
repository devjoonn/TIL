//
//  CustomButton.swift
//  SwiftUI_zzickmuk
//
//  Created by 박현준 on 2/28/24.
//

import SwiftUI

struct CustomButton: View {
    let placeholder: String
    
    init(placeholder: String) {
        self.placeholder = placeholder
    }
    
    var body: some View {
        Button {
            print("\(placeholder)")
        } label: {
            Text(placeholder)
                .foregroundStyle(.white)
                .font(.largeTitle)
                .frame(maxWidth: .infinity)
                .padding()
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding()
        }

    }
}

#Preview {
    CustomButton(placeholder: "버튼을 눌러줘")
}
