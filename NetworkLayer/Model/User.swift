import Foundation

struct User: Decodable {
    var id: Int
    var name: String?
    var company: String?
    var location: String?
    var avatar: URL?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case company
        case location
        case avatar = "avatar_url"
    }
}
