import SwiftUI
import FirebaseAuth

struct RootView: View {
    @State private var isAuthenticated = false
    @EnvironmentObject var charmVM: CharmViewModel

    var body: some View {
        Group {
            if isAuthenticated {
                HomeView()
                    .environmentObject(charmVM)
            } else {
                AuthView()
                    .environmentObject(charmVM)
            }
        }
        .onAppear {
            if Auth.auth().currentUser != nil {
                self.isAuthenticated = true
            }
        }
    }
}
