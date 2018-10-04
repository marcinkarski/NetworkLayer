import UIKit

class ViewController: UIViewController {
    
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
    
    fileprivate var request: AnyObject?
    
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
    func configureUI(with user: GitUsers.User) {
//        userView.isHidden = false
        nameLabel.text = user.name
    }
    
    func fetchUser() {
        let userResource = UsersResource()
        let userRequest = ApiRequest(resource: userResource)
        request = userRequest
        userRequest.load { [weak self] (users) in
            print(users)
            self?.activityIndicator.stopAnimating()
//            guard let us = users, let userMarcin =  else { return }
//            self?.configureUI(with: user )
//            if let avatar = user.userImage {
//                self?.fetchAvatar(for: avatar)
//            }
        }
    }
    
    func fetchAvatar(for user: Avatar) {
        guard let avatarURL = user.avatar else { return }
        let avatarRequest = ImageRequest(url: avatarURL)
        self.request = avatarRequest
        avatarRequest.load(withCompletion: { [weak self] (avatar: UIImage?) in
            guard let avatar = avatar else { return }
            self?.imageView.image = avatar
        })
    }
}
