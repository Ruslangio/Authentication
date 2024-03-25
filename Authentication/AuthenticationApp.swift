//
//  AuthenticationApp.swift
//  Authentication
//
//  Created by Ruslan Alekyan on 01.03.2024.
//

import Firebase
import SwiftUI

@main
struct AuthenticationApp: App {
    @StateObject private var server = Server()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(server)
        }
    }
}
