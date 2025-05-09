import SwiftUI

struct CharmDetailView: View {
    @EnvironmentObject var charmVM: CharmViewModel
    let charm: Charm

    @State private var selectedVariantIndex = 0
    @State private var selectedImageIndex = 0
    @State private var showingFullImage = false

    var body: some View {
        let variant = charm.variants[selectedVariantIndex]

        ScrollView {
            VStack(spacing: 24) {
                // MARK: Image Carousel (Tappable)
                TabView(selection: $selectedImageIndex) {
                    ForEach(0..<variant.images.count, id: \.self) { i in
                        Image(variant.images[i])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .tag(i)
                            .frame(maxWidth: .infinity)
                            .frame(height: 440)
                            .onTapGesture {
                                showingFullImage = true
                            }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .frame(height: 440)
                .padding(.horizontal)

                // MARK: Variant Picker
                Picker("Color", selection: $selectedVariantIndex) {
                    ForEach(0..<charm.variants.count, id: \.self) { i in
                        Text(charm.variants[i].color).tag(i)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)

                // MARK: Charm Info
                VStack(alignment: .leading, spacing: 8) {
                    Text(charm.name)
                        .font(.title2)
                        .bold()
                    Text("Collection: \(charm.collection)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(String(format: "$%.2f", variant.price))
                        .font(.headline)
                }
                .padding(.horizontal)

                // MARK: Action Buttons (✅ now with selectedVariantID)
                HStack(spacing: 20) {
                    Button(charm.owned ? "Remove from Collection" : "Add to Collection") {
                        charmVM.toggleOwned(for: charm, selectedVariantID: variant.id)
                    }
                    .buttonStyle(.borderedProminent)

                    Button(charm.wishlist ? "Remove from Wishlist" : "Add to Wishlist") {
                        charmVM.toggleWishlist(for: charm, selectedVariantID: variant.id)
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.horizontal)
            }
            .padding(.top)
        }
        .fullScreenCover(isPresented: $showingFullImage) {
            FullImageViewer(images: variant.images, selectedIndex: selectedImageIndex)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
