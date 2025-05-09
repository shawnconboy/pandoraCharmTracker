import SwiftUI

struct AuthView: View {
    @EnvironmentObject var charmVM: CharmViewModel
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        VStack(spacing: 24) {
            Text(viewModel.isLogin ? "Sign In" : "Sign Up")
                .font(.largeTitle)
                .bold()
            TextField("Email", text: $viewModel.email)
                .autocapitalization(.none)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            if !viewModel.isLogin {
                SecureField("Confirm Password", text: $viewModel.confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            if let error = viewModel.errorMessage {
                Text(error).foregroundColor(.red).font(.caption)
            }
            Button(viewModel.isLogin ? "Sign In" : "Sign Up") {
                viewModel.handleAuth()
            }
            .buttonStyle(.borderedProminent)
            Button(viewModel.isLogin ? "Need an account? Sign Up" : "Have an account? Sign In") {
                viewModel.isLogin.toggle()
            }
            .font(.footnote)
        }
        .padding()
        .fullScreenCover(isPresented: $viewModel.isAuthenticated) {
            HomeView()
                .environmentObject(charmVM)
        }
    }
}
