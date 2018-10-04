import Foundation

struct GitUser: Codable {
    var id: Int
    var name: String?
    var company: String?
    var location: String?
    var userImage: URL?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case company
        case location
        case userImage = "avatar_url"
    }
}

struct GitResult: Decodable {
    let result: [GitUser]
}
