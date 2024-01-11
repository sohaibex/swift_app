import SwiftUI

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmationPassword = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @EnvironmentObject var registerVM: RegisterViewModel

    var body: some View {
        VStack {
            Spacer()

            Text("SpaceViewer")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(Color.blue)
                .padding(.bottom, 40)
            CustomInputField(icon: "person", placeholder: "First Name", text: $firstName)
            CustomInputField(icon: "person", placeholder: "Last Name", text: $lastName)
            CustomInputField(icon: "envelope", placeholder: "Email", text: $email)
            CustomInputField(icon: "lock", placeholder: "Password", text: $password, isSecure: true)
            CustomInputField(icon: "lock", placeholder: "Confirm Password", text: $confirmationPassword, isSecure: true)


            if !registerVM.registrationError.isEmpty {
                Text(registerVM.registrationError)
                    .foregroundColor(.red)
                    .padding()
            }

            Button("Register") {
                guard password == confirmationPassword else {
                    registerVM.registrationError = "Passwords do not match"
                    return
                }
                registerVM.register(email: email, password: password, firstName: firstName, lastName: lastName)
            }
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.blue)
            .cornerRadius(25)
            .padding(.horizontal)
            .padding(.top, 20)

            Spacer()
        }
        .padding(.horizontal)
    }
}
