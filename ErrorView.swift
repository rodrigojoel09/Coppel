//
//  ErrorView.swift
//  Nativekit
//
//  Created by Joel Ramirez on 08/03/23.
//

import UIKit

class ErrorView: UIViewController {
    
    private let imageError: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "error")
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imageError)
        configConstraints()
    }
    
    func configConstraints() {
        NSLayoutConstraint.activate([imageError.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     imageError.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
    }
}
