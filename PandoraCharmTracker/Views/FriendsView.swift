import SwiftUI

struct FriendsView: View {
    var body: some View {
        VStack {
            Text("Friends")
                .font(.title)
            Spacer()
            Text("No friends yet.")
                .foregroundColor(.secondary)
            Spacer()
            Button("Add Friend") {
                // Show add friend form
            }
            .buttonStyle(.borderedProminent)
        }.padding()
    }
}
