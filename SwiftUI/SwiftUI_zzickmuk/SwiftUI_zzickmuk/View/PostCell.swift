//
//  PostCell.swift
//  SwiftUI_zzickmuk
//
//  Created by 박현준 on 2/28/24.
//

import SwiftUI

struct PostCell: View {
    var body: some View {
        HStack(alignment: .top) {
            Circle()
                .frame(width: 30, height: 30)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("스티브")
                        .font(.body)
                        .bold()
                    
                    Text("3시간")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                
                Text("요즘 iOS 개발자 어쩌구 저쩌구 고민이 많다. UIKit인지 SwiftUI인지 어쩌구 저쩌구")
                    .font(.callout)
                    .multilineTextAlignment(.leading)
            }
        }
        .padding()
        .background {
            Color.white
                .clipShape(RoundedRectangle(cornerRadius: 18))
                .shadow(color: .gray.opacity(0.5), radius: 3, x: 0, y: 3)
        }
        .padding()
    }
}


#Preview {
    PostCell()
}
