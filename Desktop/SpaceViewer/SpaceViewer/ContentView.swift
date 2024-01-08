import SwiftUI

struct ContentView: View {
    @EnvironmentObject var loginVM: LoginViewModel
    @EnvironmentObject var registerVM: RegisterViewModel

    var body: some View {
        NavigationView {
            if loginVM.isLoggedIn || registerVM.isLoggedIn {
                MainTabView() // Redirect to MainTabView instead of HomePage
                    .accentColor(Color("StarWhite"))
            } else {
                LoginView()
            }
        }
    }
}


// Only for preview purposes
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(LoginViewModel())
            .environmentObject(RegisterViewModel())
    }
}
