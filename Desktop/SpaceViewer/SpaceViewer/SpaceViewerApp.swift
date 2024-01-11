import SwiftUI
import Firebase
import FirebaseAuth

@main
struct SpaceViewerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appDelegate.loginVM)  // Provide the updated instance
                .environmentObject(appDelegate.registerVM)
        }
    }
}


// Define the AppDelegate class
class AppDelegate: NSObject, UIApplicationDelegate {
    @ObservedObject var loginVM = LoginViewModel()
    @ObservedObject var registerVM = RegisterViewModel()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()  // Initialize Firebase

        // Check if the user is already logged in
        checkAuthenticationStatus()

        return true
    }

    private func checkAuthenticationStatus() {
        if Auth.auth().currentUser != nil {
            // User is logged in, update the view models
            loginVM.isLoggedIn = true
            registerVM.isLoggedIn = true
        }
    }
}
