//
//  Server.swift
//  Authentication
//
//  Created by Ruslan Alekyan on 01.03.2024.
//

import Firebase
import FirebaseFirestore
import Foundation

@MainActor
class Server: ObservableObject {
    @Published var userSession: Firebase.User?              // Для аутентификации
    @Published var currentUser: User?                       // Для хранения дополнительной информации о пользователе
    
    private var userCollection = Firestore.firestore().collection("users")
    
    init() {
        userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signIn(email: String, password: String) async throws {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        userSession = result.user
        await fetchUser()
    }
    
    func createUser(fullname: String, withEmail email: String, password: String) async throws {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        userSession = result.user
        
        let user = User(id: result.user.uid, fullname: fullname, email: email)
        let encodedUser = try Firestore.Encoder().encode(user)
        try await userCollection.document(user.id).setData(encodedUser)
        await fetchUser()
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            userSession = nil
            currentUser = nil
        } catch {
            print("DEBUG: Failed to sign out with error: \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
        Task {
            do {
                guard let id = Auth.auth().currentUser?.uid else { return }
                try await userCollection.document(id).delete()
                try await userSession?.delete()
                userSession = nil
                currentUser = nil
            } catch {
                print("DEBUG: Failed to delete user with error: \(error.localizedDescription)")
            }
        }
    }
    
    private func fetchUser() async {
        guard let id = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await userCollection.document(id).getDocument() else { return }
        currentUser = try? snapshot.data(as: User.self)
    }
}
