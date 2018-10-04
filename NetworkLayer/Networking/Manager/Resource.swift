import Foundation

struct Resource {
    let url: URL
    let path: String?
    let method: String
    
    init(url: URL, path: String? = nil, method: String = "GET") {
        self.url = url
        self.path = path
        self.method = method
    }
}
