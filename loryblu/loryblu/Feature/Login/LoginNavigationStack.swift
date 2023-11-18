//
//  LoginStack.swift
//  LoryBlu
//
//  Created by dede.exe on 17/11/23.
//

import SwiftUI

struct LoginNavigationStack: View {
    typealias NavigationCoordinator = LoginNavigationCoordinator
    
    @ObservedObject var coordinator: NavigationCoordinator
    
    init() {
        coordinator = .init()
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            LoginView.build()
                .navigationDestination(for: NavigationCoordinator.Destination.self) { destination in
                    coordinator.destinationView(to: destination)
                }
                .environmentObject(coordinator)
        }
    }
}

#Preview {
    LoginNavigationStack()
}
