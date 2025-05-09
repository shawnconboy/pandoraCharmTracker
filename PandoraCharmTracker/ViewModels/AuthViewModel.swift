import Foundation
import FirebaseAuth
import FirebaseFirestore
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var isLogin = true
    @Published var errorMessage: String?
    @Published var isAuthenticated = false
    @Published var isCheckingAuth = true

    init() {
        // Auto-login on app launch
        DispatchQueue.main.async {
            if Auth.auth().currentUser != nil {
                self.isAuthenticated = true
                print("Auto-logged in as: \(Auth.auth().currentUser?.uid ?? "")")
            }
            self.isCheckingAuth = false
        }
    }

    func handleAuth() {
        errorMessage = nil
        if isLogin {
            login()
        } else {
            register()
        }
    }

    private func login() {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                    print("Login error: \(error.localizedDescription)")
                } else if let user = result?.user {
                    self?.isAuthenticated = true
                    print("Login successful for UID: \(user.uid)")
                }
            }
        }
    }

    private func register() {
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match."
            print("Password mismatch during registration")
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                    print("Registration error: \(error.localizedDescription)")
                } else if let user = result?.user {
                    self?.isAuthenticated = true
                    print("Registration successful for UID: \(user.uid)")

                    // Write to Firestore (optional)
                    let db = Firestore.firestore()
                    db.collection("users").document(user.uid).setData([
                        "email": self?.email ?? "",
                        "createdAt": FieldValue.serverTimestamp(),
                        "shareCollection": true,
                        "shareWishlist": true
                    ]) { err in
                        if let err = err {
                            print("Error writing user to Firestore: \(err.localizedDescription)")
                        } else {
                            print("User document successfully written to Firestore.")
                        }
                    }
                }
            }
        }
    }
}
