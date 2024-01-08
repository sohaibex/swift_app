import Foundation
import FirebaseAuth

class RegisterViewModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var registrationError = ""

    func register(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.registrationError = error.localizedDescription
                } else {
                    self?.isLoggedIn = true
                }
            }
        }
    }
}
