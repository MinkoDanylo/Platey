//
//  Navigator.swift
//  Paytey
//
//  Created by Minko Danylo on 09.10.2026.
//

import Combine
import SwiftUI

enum Route: Hashable, Equatable {
    case login
    case introRegister
    case main
    case settings

    func hash(into hasher: inout Hasher) {
        switch self {
        case .login:
            hasher.combine("login")
        case .introRegister:
            hasher.combine("introRegister")
        case .main:
            hasher.combine("main")
        case .settings:
            hasher.combine("settings")
        }
    }
}

final class Navigator: ObservableObject {
    @Published var path = NavigationPath()

    func push(_ route: Route) {
        path.append(route)
    }

    func pop() {
        path.removeLast()
    }

    func popToRoot() {
        path.removeLast(path.count)
    }
}

