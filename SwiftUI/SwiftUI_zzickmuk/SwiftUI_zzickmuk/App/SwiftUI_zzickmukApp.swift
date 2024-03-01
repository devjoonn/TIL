//
//  SwiftUI_zzickmukApp.swift
//  SwiftUI_zzickmuk
//
//  Created by 박현준 on 2/28/24.
//

import SwiftUI

@main
struct SwiftUI_zzickmukApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(NavigationPathFinder.shared)
        }
    }
}
