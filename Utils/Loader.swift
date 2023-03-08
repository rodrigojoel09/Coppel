//
//  Loader.swift
//  Nativekit
//
//  Created by Joel Ramirez on 07/03/23.
//

import Foundation
import UIKit

class Loader: UIView{
    
    private lazy var actInd:UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView()
        aiv.style = .large
        return aiv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
       
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        let loadingView: UIView = UIView()
        loadingView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
       
        loadingView.addSubview(actInd)
        
    
        actInd.anchor(top: nil,
                         leading: nil,
                         bottom: nil,
                         trailing: nil,
                         size: CGSize(width: 80, height: 80))
       addSubview(loadingView)
        
        
        loadingView.anchor(top: nil,
                         leading: nil,
                         bottom: nil,
                         trailing: nil,
                         size: CGSize(width: 80, height: 80))
    }
    
    
    func startIndicator(){
        actInd.startAnimating()
    }
    
    func stopIndicator() {
        actInd.startAnimating()
    }
}

extension UIView {
    
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero,size: CGSize = .zero){
        
        translatesAutoresizingMaskIntoConstraints  = false
        if let top = top{
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading{
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom{
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        if let trailing = trailing{
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0{
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}
