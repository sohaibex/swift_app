import SwiftUI
import Firebase

@main
struct SpaceViewerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    // Shared instances of the view models
    var loginVM = LoginViewModel()
    var registerVM = RegisterViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(loginVM)  // Provide the shared instance to the environment
                .environmentObject(registerVM)
        }
    }
}

// Define the AppDelegate class
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()  // Initialize Firebase
        return true
    }
}
