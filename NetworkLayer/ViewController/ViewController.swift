import UIKit

class ViewController: UIViewController {
    
    fileprivate var request: AnyObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        fetchUser()
    }
    
    func fetchUser() {
        let userResource = UserResource()
        let questionsRequest = ApiRequest(resource: userResource)
        request = questionsRequest
        questionsRequest.load { [weak self] (user) in
            print(user)
        }
    }
}
