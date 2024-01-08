import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isAnimating = false
    @EnvironmentObject var viewModel: LoginViewModel

    var body: some View {
        VStack {
            Spacer()

            // Logo or App Name
                     Text("SpaceViewer")
                         .font(.largeTitle)
                         .fontWeight(.heavy)
                         // Use the gradient as the text color
                         .foregroundLinearGradient(colors: [.GalaxyBlue, .GalaxyPurple], startPoint: .leading, endPoint: .trailing)
                         .scaleEffect(isAnimating ? 1.0 : 0.9)
                         .onAppear {
                             withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                                 isAnimating = true
                             }
                         }


            // Email input
            CustomInputField(icon: "envelope", placeholder: "Email", text: $email)
                .padding(.top, 40)

            // Password input
            CustomInputField(icon: "lock", placeholder: "Password", text: $password, isSecure: true)
                .padding(.top, 20)

            // Login button
            Button(action: {
                viewModel.login(email: email, password: password)
            }) {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(LinearGradient(gradient: Gradient(colors: [.GalaxyBlue, .GalaxyPurple]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(25)
            }
            .padding(.top, 30)
            .padding(.horizontal)

            // Register navigation link
            NavigationLink(destination: RegisterView()) {
                Text("Don't have an account? Register")
                    .foregroundColor(.GalaxyBlue) // Using the extension
            }
            .padding(.top, 20)

            Spacer()
        }
        .padding(.horizontal)
     
    }
}

struct CustomInputField: View {
    var icon: String
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = false

    var body: some View {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.GalaxyDark) // Corrected
                if isSecure {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                }
            }
            .padding()
            .background(Color.GalaxyDark.opacity(0.1)) // Corrected
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.GalaxyDark, lineWidth: 1)) // Corrected
            .foregroundColor(.GalaxyDark) // Corrected
        }
    }

extension View {
    func foregroundLinearGradient(colors: [Color], startPoint: UnitPoint, endPoint: UnitPoint) -> some View {
        self.overlay(LinearGradient(gradient: Gradient(colors: colors), startPoint: startPoint, endPoint: endPoint))
            .mask(self)
    }
}

extension Color {
    static let GalaxyBlue = Color(red: 13 / 255, green: 27 / 255, blue: 42 / 255)
    static let GalaxyPurple = Color(red: 93 / 255, green: 63 / 255, blue: 211 / 255)
    static let GalaxyLight = Color(red: 208 / 255, green: 225 / 255, blue: 249 / 255)
    static let GalaxyDark = Color(red: 4 / 255, green: 12 / 255, blue: 24 / 255)
}
