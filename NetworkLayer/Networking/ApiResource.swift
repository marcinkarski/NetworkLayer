import Foundation

protocol ApiResource {
    associatedtype Model: Decodable
    func makeModel(data: Data) -> Model
}

extension ApiResource {
	var url: URL {
		let base = "https://api.github.com/users/marcinkarski"
		return URL(string: base)!
	}
}

struct UserResource: ApiResource {
    func makeModel(data: Data) -> User? {
        let decoder = JSONDecoder()
        guard let user = try? decoder.decode(User.self, from: data) else {
            return nil
        }
        return user
    }
}
