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

struct UserResource: ApiResource {
    let methodPath = "/users/"
    func makeModel(data: Data) -> User? {
        let decoder = JSONDecoder()
        guard let user = try? decoder.decode(User.self, from: data) else {
            return nil
        }
        return user
    }
}
