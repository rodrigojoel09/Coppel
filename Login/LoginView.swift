//
//  LoginView.swift
//  Nativekit
//
//  Created by Joel Ramirez on 06/03/23.
//

import Foundation


/*
final class LoginView: UIView, UITextFieldDelegate {
    
    
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
        button.addTarget(LoginView.self, action: #selector(makeLogin), for: .touchUpInside)
        
        return button
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "texto ejemplo UIKit"
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 16)
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        
        return label
    }()
    
    
    override init(frame: CGRect) {
            super.init(frame: .zero)
            setup()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    private func setup() {
        addSubViews()
        configureConstraints()
        
        userText.delegate = self
        passText.delegate = self
    }
    
    private func addSubViews() {
        [imageExample, containerStackView].forEach(addSubview)
    }
        
    private func configureConstraints() {
        imageExample.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        imageExample.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        containerStackView.topAnchor.constraint(equalTo: imageExample.bottomAnchor, constant: 60).isActive = true
        containerStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 30).isActive = true
        containerStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -30).isActive = true
        
        [userText, passText, loginButton, errorLabel].forEach(containerStackView.addArrangedSubview)
        userText.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passText.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    
    @objc func makeLogin() {
        guard let user = userText.text,
              let pass = passText.text else {
            print("Ingrese ambos valores")
            return
        }
        delegate?.pass = pass
        delegate?.usuario = user
        delegate?.makeLogin(user: user,pass: pass)
    }
    
}
*/
