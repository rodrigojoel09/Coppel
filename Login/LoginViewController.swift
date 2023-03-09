//
//  LoginViewController.swift
//  Nativekit
//
//  Created by Joel Ramirez on 05/03/23.
//

import Foundation
import UIKit

final class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var viewModel = LoginViewModel()
    var modelSession = ProfileViewModel()
    
    var movieDataToken: MovieDataResponse?
    
    private let imageExample: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "mvbd")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor.constraint(equalToConstant: 140).isActive = true
        image.widthAnchor.constraint(equalToConstant: 140).isActive = true
   
        return image
    }()
    
    private let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        
        return stack
    }()
    
    private let userText: UITextField = {
       let textField = UITextField()
        textField.backgroundColor = .gray.withAlphaComponent(0.1)
        textField.placeholder = "Ingresa tu usuario"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.layer.cornerRadius = 10
        
        return textField
    }()
    
    private let passText: UITextField = {
       let passText = UITextField()
        passText.backgroundColor = .gray.withAlphaComponent(0.1)
        passText.placeholder = "Ingresa tu contraseña"
        passText.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        passText.leftViewMode = .always
        passText.font = UIFont.systemFont(ofSize: 16)
        passText.layer.cornerRadius = 10
        passText.isSecureTextEntry = true
        
        return passText
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("ENTRAR", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.layer.cornerRadius = 10
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(makeLogin), for: .touchUpInside)
        
        return button
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Invalid username and/or password: You did not provide a valid login"
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 16)
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addSubViews()
        configureConstraints()
        
        userText.delegate = self
        passText.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
            view.addGestureRecognizer(tapGesture)
        
        viewModel.getToken()
        viewModel.statusCode.bind { [weak self] code in
            self?.hideLoader()
            if code == .success {
                print("Todo OK, Login")
                let rootVC = ListMoviesViewController()
                let navVC = UINavigationController(rootViewController: rootVC)
                navVC.modalPresentationStyle = .fullScreen
                self?.present(navVC, animated: true)
               
                self?.modelSession.createSession()
                
            }else {
                self?.errorLabel.isHidden = false
                print("Error de Login")
            }
        }
        
    }
    
    @objc func makeLogin() {
        guard let user = userText.text,
              let pass = passText.text else {
            print("Ingrese ambos valores")
            return
        }
        showLoader()
        viewModel.makeLogin(userName: user, password: pass)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    private func addSubViews() {
        [imageExample, containerStackView].forEach(view.addSubview)
    }
        
    private func configureConstraints() {
        imageExample.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        imageExample.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        containerStackView.topAnchor.constraint(equalTo: imageExample.bottomAnchor, constant: 60).isActive = true
        containerStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        containerStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        
        [userText, passText, loginButton, errorLabel].forEach(containerStackView.addArrangedSubview)
        userText.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passText.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}


extension LoginViewController {
    func showLoader(){
        hideLoader()
        
        let loader = Loader()
        view.addSubview(loader)
        
        loader.anchor(top: nil,
                      leading: nil,
                      bottom: nil,
                      trailing: nil,
                      size: CGSize(width: view.frame.width, height: view.frame.height))
        
        loader.startIndicator()
        
    }
    
    func hideLoader(){
        view.subviews.forEach { currentView in
            if let loader = currentView as? Loader{
                loader.stopIndicator()
                loader.removeFromSuperview()
            }
        }
    }
}


