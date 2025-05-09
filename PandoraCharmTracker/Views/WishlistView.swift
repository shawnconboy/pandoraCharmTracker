import SwiftUI

struct WishlistView: View {
    @EnvironmentObject var charmVM: CharmViewModel

    var body: some View {
        NavigationView {
            List(charmVM.wishlistCharms) { charm in
                NavigationLink(destination: CharmDetailView(charm: charm)) {
                    Text(charm.name)
                }
            }
            .navigationTitle("My Wishlist")
        }
    }
}
