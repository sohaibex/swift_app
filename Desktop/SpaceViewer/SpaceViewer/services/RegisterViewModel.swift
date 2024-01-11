import Foundation
import FirebaseAuth

class RegisterViewModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var registrationError = ""

    func register(email: String, password: String, firstName: String, lastName: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.registrationError = error.localizedDescription
                } else {
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = "\(firstName) \(lastName)"
                    changeRequest?.commitChanges { [weak self] error in
                        if let error = error {
                            self?.registrationError = error.localizedDescription
                        } else {
                            self?.isLoggedIn = true
                        }
                    }
                }
            }
        }
    }
}
