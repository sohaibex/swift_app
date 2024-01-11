import Foundation
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var userEmail: String? = nil

    func login(email: String, password: String) {
        print("Attempting to log in with email: \(email)")
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                } else if let user = authResult?.user {
                    print("Login successful for email: \(email)")
                    self?.isLoggedIn = true
                    self?.userEmail = user.email // Update the userEmail property
                } else {
                    print("Unexpected error during login.")
                }
            }
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            isLoggedIn = false
            userEmail = nil
            print("User logged out successfully")
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError)")
        }
    }

}
