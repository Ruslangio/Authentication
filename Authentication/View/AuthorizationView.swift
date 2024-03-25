//
//  AuthorizationView.swift
//  Authentication
//
//  Created by Ruslan Alekyan on 01.03.2024.
//

import SwiftUI

struct AuthorizationView: View {
    @EnvironmentObject private var server: Server
    
    @State private var email = ""
    @State private var password = ""
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    private var isFormValid: Bool {
        !email.isEmpty && password.count >= 6
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Image(systemName: "person.circle")
                    .font(.system(size: 100))
                
                InputView(text: $email, title: "Email")
                    .keyboardType(.emailAddress)
                InputView(text: $password, title: "Password", isSecureField: true)
                EnterButton(text: "Sign In", isValid: isFormValid) {
                    Task {
                        do {
                            try await server.signIn(email: email, password: password)
                        } catch {
                            alertMessage = error.localizedDescription
                            showAlert.toggle()
                        }
                    }
                }
                
                Spacer()
                
                HStack {
                    Text("Don't have an account?")
                    NavigationLink("Sign Up") {
                        RegistrationView()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Authorization")
            .padding(.horizontal)
            .alert(alertMessage, isPresented: $showAlert) {
                Button("OK") {}
            }
        }
    }
}

#Preview {
    AuthorizationView()
        .environmentObject(Server())
}
