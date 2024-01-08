import SwiftUI

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmationPassword = ""
    @EnvironmentObject var registerVM: RegisterViewModel

    var body: some View {
        VStack {
            Spacer()

            // Logo or App Name
            Text("SpaceViewer")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundLinearGradient(colors: [.GalaxyBlue, .GalaxyPurple], startPoint: .leading, endPoint: .trailing)
                .padding(.bottom, 40)

            // Email input
            CustomInputField(icon: "envelope", placeholder: "Email", text: $email)

            // Password input
            CustomInputField(icon: "lock", placeholder: "Password", text: $password, isSecure: true)

            // Confirm Password input
            CustomInputField(icon: "lock", placeholder: "Confirm Password", text: $confirmationPassword, isSecure: true)

            if !registerVM.registrationError.isEmpty {
                Text(registerVM.registrationError)
                    .foregroundColor(.red)
                    .padding()
            }

            // Register button
            Button("Register") {
                guard password == confirmationPassword else {
                    registerVM.registrationError = "Passwords do not match"
                    return
                }
                registerVM.register(email: email, password: password)
            }
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(LinearGradient(gradient: Gradient(colors: [.GalaxyBlue, .GalaxyPurple]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(25)
            .padding(.horizontal)
            .padding(.top, 20)

            Spacer()
        }
        .padding(.horizontal)
    }
}

