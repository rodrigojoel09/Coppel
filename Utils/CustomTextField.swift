//
//  CustomTextField.swift
//  Nativekit
//
//  Created by Joel Ramirez on 06/03/23.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    private let underline = CALayer()
    
    private func setupUnderline() {
    
        borderStyle = .none
            
   
        let lineWidth: CGFloat = 1.0
        underline.borderColor = UIColor.darkGray.cgColor
        underline.frame = CGRect(
            x: 0,
            y: frame.size.height - lineWidth,
            width: frame.size.width,
            height: frame.size.height
        )
        underline.borderWidth = lineWidth
            
   
        layer.addSublayer(underline)
        layer.masksToBounds = true
        
        func setNeedsLayout() {
            super.setNeedsLayout()
            setupUnderline()
        }
        
        var intrinsicContentSize: CGSize {
            return CGSize(width: UIView.noIntrinsicMetric, height: 35.0)
        }
    }
}
