//
//  ProfileViewController.swift
//  Nativekit
//
//  Created by Joel Ramirez on 08/03/23.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    let viewModel = ProfileViewModel()
    
    var profile = PerfilResponse() {
        didSet {
            DispatchQueue.main.async {
                self.labelUser.text = "Nombre: \(self.profile.name)"
                self.labelUser.text = "User Name: \(self.profile.username)"
            }
        }
    }
    
    private let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 2
        
        return stack
    }()
    
    private let containerChild: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 2
        
        return stack
    }()
    
    private let imageProfile: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "user")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let labelUser: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 16)
        label.text = "The resource you requested could not be found"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let laberUserName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 16)
        label.text = "The resource you requested could not be found"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cerrar sesión", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.layer.cornerRadius = 10
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(logout), for: .touchUpInside)
        
        return button
    }()
    
    private let labelTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = "Favorites Shows"
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 26)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = " MI PERFIL"
        view.backgroundColor = .white
    
        view.addSubview(containerStackView)
        view.addSubview(logoutButton)
        
        containerStackView.addArrangedSubview(imageProfile)
        containerStackView.addArrangedSubview(containerChild)
        containerChild.addArrangedSubview(labelUser)
        containerChild.addArrangedSubview(laberUserName)
        
        configConstraints()
        
        viewModel.getAccount { result in
            print(result)
        }
    }
    private func configConstraints() {
        NSLayoutConstraint.activate([containerStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
                                     containerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
                                     containerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
                                     logoutButton.topAnchor.constraint(equalTo: containerStackView.bottomAnchor, constant: 20),
                                     logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)])
    }
    
    @objc func logout() {
        
        let cerrarSession = viewModel.deleteSession()
        if cerrarSession == true {
            let vc = LoginViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = LoginViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
    
    
}
