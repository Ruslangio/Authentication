//
//  ProfileView.swift
//  Authentication
//
//  Created by Ruslan Alekyan on 01.03.2024.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var server: Server
    
    @State private var showDeleteConfirmation = false
    
    var body: some View {
        NavigationStack {
            if let user = server.currentUser {
                List {
                    HStack {
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: 70, height: 70)
                            .background(.tertiary)
                            .clipShape(Circle())
                        VStack(alignment: .leading) {
                            Text(user.fullname)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text(user.email)
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }
                    } 
                    
                    Button("Delete Account", role: .destructive) {
                        showDeleteConfirmation.toggle()
                    }
                    .confirmationDialog("Are you sure you want to delete your account?", isPresented: $showDeleteConfirmation, titleVisibility: .visible) {
                        Button("Delete", role: .destructive) {
                            server.deleteAccount()
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Profile")
                .toolbar {
                    Button("Sign Out") {
                        server.signOut()
                    }
                }
            }
        }
    }
}

#Preview {
    let server = Server()
    server.currentUser = User(id: "1", fullname: "Ruslan Alekyan", email: "Alekyan_2014@mail.ru")
    return ProfileView()
        .environmentObject(server)
}
