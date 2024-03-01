//
//  CustomCount.swift
//  SwiftUI_zzickmuk
//
//  Created by 박현준 on 2/29/24.
//

import SwiftUI

struct CustomCount: View {
    @State private var count: Int = 0
    
    var body: some View {
        let _ = Self._printChanges()
        
        VStack(spacing: 30) {
            Text(count.formatted())
                .font(.largeTitle)
            
            HStack(spacing: 20) {
                Button("카운트 증가") { count += 1 }
                    .tint(.black)
                Button("카운트 감소") { count -= 1 }
                    .tint(.black)
            }
        }
    }
}

#Preview {
    CustomCount()
}
