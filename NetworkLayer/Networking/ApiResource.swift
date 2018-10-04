import Foundation

protocol ApiResource {
    associatedtype Model: Decodable
    var methodPath: String { get }
    func makeModel(data: Data) -> Model
}

extension ApiResource {
    var url: URL {
        let base = "https://api.github.com"
        let user = "marcinkarski"
        let url = base + methodPath + user
        return URL(string: url)!
    }
}

struct UsersResource: ApiResource {
    let methodPath = "/users/"
    func makeModel(data: Data) -> GitUsers.User? {
        let decoder = JSONDecoder()
        guard let users = try? decoder.decode(GitUsers.User.self, from: data) else { return nil }
        return users
    }
}
