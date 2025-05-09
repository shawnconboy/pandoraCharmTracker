import SwiftUI

struct WishlistGridView: View {
    let charms: [Charm]

    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
            ForEach(charms) { charm in
                NavigationLink(destination: CharmDetailView(charm: charm)) {
                    VStack(spacing: 8) {
                        let imageName = charm.variants.first(where: { $0.id == charm.selectedVariantID })?.images.first
                            ?? charm.variants.first?.images.first
                            ?? "placeholder"

                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 160)
                            .padding(6)
                            .background(Color(.systemBackground))
                            .cornerRadius(12)
                            .shadow(radius: 3)

                        Text(charm.name)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.primary)
                            .padding(.horizontal, 4)
                    }
                }
            }
        }
        .padding()
    }
}
