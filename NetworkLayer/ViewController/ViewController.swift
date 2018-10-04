import UIKit

class ViewController: UIViewController {
    
    fileprivate var request: AnyObject?
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.style = .gray
        indicator.startAnimating()
        return indicator
    }()
    
    let imageView: UIImageView = {
        let placeholder = UIImage(named: "bottomViewImagePlaceholder")
        let image = UIImageView(image: placeholder)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 2
        image.layer.masksToBounds = true
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchUser()
    }

    private func setup() {
        view.backgroundColor = .lightGray
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(activityIndicator)
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 100).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

private extension ViewController {
    
    func configureUI(with user: GitUser) {
//        userView.isHidden = false
        nameLabel.text = user.name
    }
    
    func fetchUser() {
        let userResource = UsersResource()
        let userRequest = ApiRequest(resource: userResource)
        self.request = userRequest
        userRequest.load { [weak self] (users) in
            print(users)
            self?.activityIndicator.stopAnimating()

//            guard let u = users, let userMarcin = u?.name else { return }
//            self?.configureUI(with: <#T##GitUsers#>)
//            if let avatar = userMarcin {
//                self?.fetchAvatar(for: avatar)
//            }
//            guard let a = users else { return }
//            let userAvatar = a?.userImage
//            if let avatar = userAvatar {
//                self?.fetchAvatar(for: avatar)
//            }
//            guard let a = users else {return}
//            let ua = a?.userImage
//            if let userAvatar = ua {
//                self?.fetchAvatar(for: userAvatar)
//            }
        }
    }
    
    func fetchAvatar(for user: GitUser) {
        guard let avatarURL = user.userImage else { return }
        let avatarRequest = ImageRequest(url: avatarURL)
        self.request = avatarRequest
        avatarRequest.load(withCompletion: { [weak self] (avatar: UIImage?) in
            guard let avatar = avatar else { return }
            self?.imageView.image = avatar
        })
    }
}
