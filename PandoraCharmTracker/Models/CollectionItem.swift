import Foundation

struct CollectionItem: Identifiable, Codable {
    var id: String { charmId }
    var userId: String
    var charmId: String
    var note: String?
    var dateAdded: Date
}
