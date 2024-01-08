import Foundation
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var isLoggedIn = false

    func login(email: String, password: String) {
        print("Attempting to log in with email: \(email)")
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                } else if authResult?.user != nil {
                    print("Login successful for email: \(email)")
                    self?.isLoggedIn = true
                } else {
                    print("Unexpected error during login.")
                }
            }
        }
    }
}
