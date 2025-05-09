import SwiftUI

struct MyCollectionView: View {
    @EnvironmentObject var charmVM: CharmViewModel

    var body: some View {
        NavigationView {
            List(charmVM.ownedCharms) { charm in
                NavigationLink(destination: CharmDetailView(charm: charm)) {
                    Text(charm.name)
                }
            }
            .navigationTitle("My Collection")
        }
    }
}
