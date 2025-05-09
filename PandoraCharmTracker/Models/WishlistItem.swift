import Foundation

struct WishlistItem: Identifiable, Codable {
    var id: String { charmId }
    var userId: String
    var charmId: String
}
