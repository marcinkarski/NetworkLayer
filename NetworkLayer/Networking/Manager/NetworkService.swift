import Foundation

final class NetworkService: Networking {
    private let session: URLSession
    
    init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.session = URLSession(configuration: configuration)
    }
    
    @discardableResult func fetch(resource: Resource, completion: @escaping (Data?) -> Void) -> URLSessionTask? {
        guard let request = makeRequest(resource: resource) else {
            completion(nil)
            return nil
        }
        
        let task = session.dataTask(with: request, completionHandler: { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            completion(data)
        })
        
        task.resume()
        return task
    }
    
    private func makeRequest(resource: Resource) -> URLRequest? {
        let url = resource.path.map({ resource.url.appendingPathComponent($0) }) ?? resource.url
        guard let component = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            assertionFailure()
            return nil
        }

        guard let resolvedUrl = component.url else {
            assertionFailure()
            return nil
        }
        
        var request = URLRequest(url: resolvedUrl)
        request.httpMethod = resource.method
        return request
    }
}
