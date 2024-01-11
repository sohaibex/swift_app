import SwiftUI
import FirebaseAuth

struct ProfilePage: View {
    @EnvironmentObject var loginVM: LoginViewModel
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var userEmail = ""
    let username = "SpaceExplorer"
    @State private var isLoggedOut = false // Added a state variable to control navigation

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.white, Color("DeepSpaceBlue")]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    profileImageView
                        .padding(.top, 50)

                    Text(username)
                        .font(.title2)
                        .foregroundColor(Color("StarWhite"))
                        .padding(.top, 10)

                    Text(userEmail)
                        .font(.title)
                        .foregroundColor(Color("StarWhite"))
                        .shadow(color: Color.black.opacity(0.7), radius: 5, x: 0, y: 2)
                        .padding(.top, 10)

                    Text("\(firstName) \(lastName)")
                        .font(.title2)
                        .foregroundColor(Color("StarWhite"))
                        .padding(.bottom, 10)

                    Button(action: {
                        loginVM.logout()
                        isLoggedOut = true // Set the state variable to true when logging out
                    }) {
                        Text("Logout")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .cornerRadius(10)
                            .shadow(color: Color.red.opacity(0.5), radius: 10, x: 0, y: 10)
                            .padding(.horizontal, 20)
                    }
                    .disabled(isLoggedOut) // Disable the button after logging out

                    Spacer()
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                // Fetch and set user's email from Firebase user profile
                if let user = Auth.auth().currentUser {
                    userEmail = user.email ?? "No Email"
                    fetchUserFullName(user)
                }
            }
            .background(
                NavigationLink("", destination: LoginView(), isActive: $isLoggedOut)
                    .opacity(0) // Hidden navigation link to navigate back to the login page after logging out
            )
        }
    }

    private var profileImageView: some View {
        Group {
            // Replace this with your actual user profile image logic
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
        .frame(width: 120, height: 120)
        .clipShape(Circle())
        .overlay(Circle().stroke(Color("StarWhite"), lineWidth: 3))
        .shadow(color: Color.black.opacity(0.7), radius: 5, x: 0, y: 2)
    }

    private func fetchUserFullName(_ user: User) {
        // Fetch and set user's first name and last name from Firebase user profile
        if let displayName = user.displayName {
            let components = displayName.components(separatedBy: " ")
            if components.count >= 2 {
                firstName = components[0]
                lastName = components[1]
            }
        }
    }
}
