//
//  PayteyApp.swift
//  Paytey
//
//  Created by Мінько Данило on 09.10.2026.
//

import SwiftUI
import SwiftData

@main
struct PayteyApp: App {
    @StateObject private var navigation = Navigator()
    
    var body: some Scene {
    WindowGroup {
        NavigationStack(path: $navigation.path) {
            IntroView()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .main:
                        MainScreen()
                    case .login:
                        LoginScreen()
                    case .introRegister:
                        IntroSetupScreen()
                    case .settings:
                        SettingScreen()
                    }
                }
        }
//        .environment(\.appTheme, colorScheme == .dark ? .dark : .light)
        .environmentObject(navigation)
    }
}
    }


