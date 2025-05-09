import Foundation

enum FriendshipStatus: String, Codable {
    case pending
    case accepted
    case rejected
}

struct Friendship: Identifiable, Codable {
    var id: String { requesterId + "_" + receiverId }
    var requesterId: String
    var receiverId: String
    var status: FriendshipStatus
}
