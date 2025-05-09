import Foundation

struct Charm: Identifiable, Codable, Equatable {
    let id: String
    let name: String
    let collection: String
    let variants: [CharmVariant]
    var owned: Bool
    var wishlist: Bool
    var selectedVariantID: String?
}

struct CharmVariant: Identifiable, Codable, Equatable {
    let id: String
    let color: String
    let price: Double
    let images: [String]
}
