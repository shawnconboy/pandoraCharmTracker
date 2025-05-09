import Foundation

class CharmViewModel: ObservableObject {
    @Published var allCharms: [Charm] = []

    private let saveKey = "savedCharms"

    var ownedCharms: [Charm] {
        allCharms.filter { $0.owned }
    }

    var wishlistCharms: [Charm] {
        allCharms.filter { $0.wishlist }
    }

    init() {
        loadCharms()
    }

    func toggleOwned(for charm: Charm, selectedVariantID: String) {
        if let index = allCharms.firstIndex(where: { $0.id == charm.id }) {
            allCharms[index].owned.toggle()
            allCharms[index].selectedVariantID = selectedVariantID
            saveCharms()
        }
    }

    func toggleWishlist(for charm: Charm, selectedVariantID: String) {
        if let index = allCharms.firstIndex(where: { $0.id == charm.id }) {
            allCharms[index].wishlist.toggle()
            allCharms[index].selectedVariantID = selectedVariantID
            saveCharms()
        }
    }

    private func loadCharms() {
        // Load base catalog from bundled JSON
        guard let url = Bundle.main.url(forResource: "charm_catalog", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              var charms = try? JSONDecoder().decode([Charm].self, from: data)
        else {
            print("Failed to load charm catalog.")
            return
        }

        // Load saved states (owned/wishlist) from UserDefaults
        if let savedData = UserDefaults.standard.data(forKey: saveKey),
           let savedCharms = try? JSONDecoder().decode([Charm].self, from: savedData) {
            for i in 0..<charms.count {
                if let saved = savedCharms.first(where: { $0.id == charms[i].id }) {
                    charms[i].owned = saved.owned
                    charms[i].wishlist = saved.wishlist
                    charms[i].selectedVariantID = saved.selectedVariantID
                }
            }
        }

        self.allCharms = charms
    }

    private func saveCharms() {
        if let data = try? JSONEncoder().encode(allCharms) {
            UserDefaults.standard.set(data, forKey: saveKey)
        }
    }
}
