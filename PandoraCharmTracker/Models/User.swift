import Foundation

struct User: Identifiable, Codable {
    var id: String
    var email: String
    var username: String
    var friendCodes: [String]
    var isCollectionPublic: Bool
    var isWishlistPublic: Bool
}
