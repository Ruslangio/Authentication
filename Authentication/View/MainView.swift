//
//  MainView.swift
//  Authentication
//
//  Created by Ruslan Alekyan on 01.03.2024.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var server: Server
    
    var body: some View {
        Group {
            if server.userSession == nil {
                AuthorizationView()
            } else {
                ProfileView()
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(Server())
}
