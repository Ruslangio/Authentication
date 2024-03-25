//
//  RegistrationView.swift
//  Authentication
//
//  Created by Ruslan Alekyan on 01.03.2024.
//

import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject private var server: Server
    @Environment(\.dismiss) private var dismiss
    
    @State private var fullname = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    private var isFormValid: Bool {
        !fullname.isEmpty && !email.isEmpty && password.count >= 6 && password == confirmPassword
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Image(systemName: "person.circle")
                    .font(.system(size: 100))
                
                InputView(text: $fullname, title: "Fullname")
                    .textInputAutocapitalization(.words)
                InputView(text: $email, title: "Email")
                    .keyboardType(.emailAddress)
                InputView(text: $password, title: "Password", isSecureField: true)
                InputView(text: $confirmPassword, title: "Confirm password", isSecureField: true)
                EnterButton(text: "Sign Up", isValid: isFormValid) {
                    Task {
                        do {
                            try await server.createUser(fullname: fullname, withEmail: email, password: password)
                        } catch {
                            alertMessage = error.localizedDescription
                            showAlert.toggle()
                        }
                    }
                }
                
                Spacer()
                
                HStack {
                    Text("Already have an account?")
                    Button("Sign In") {
                        dismiss()
                    }
                }
            }
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Registration")
            .padding(.horizontal)
            .alert(alertMessage, isPresented: $showAlert) {
                Button("OK") {}
            }
        }
    }
}

#Preview {
    RegistrationView()
        .environmentObject(Server())
}
