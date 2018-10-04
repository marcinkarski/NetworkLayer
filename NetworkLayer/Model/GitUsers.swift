import Foundation

struct GitUsers: Codable {
    struct User: Codable {
        var id: Int
        var name: String?
        var company: String?
        var location: String?
        var userImage: Avatar?
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case company
            case location
        }
    }
    public let items: [User]
}

struct Avatar: Codable {
    var avatar: URL?
    
    enum CodingKeys: String, CodingKey {
        case avatar = "avatar_url"
    }
}
