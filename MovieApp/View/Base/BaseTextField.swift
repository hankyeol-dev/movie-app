//
//  BaseTextField.swift
//  MovieApp
//
//  Created by 강한결 on 6/28/24.
//

import UIKit

class BaseTextField: UITextField {
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var padding = super.leftViewRect(forBounds: bounds)
        padding.origin.x += 8
        
        return padding
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var padding = super.rightViewRect(forBounds: bounds)
        padding.origin.x -= 8
        
        return padding
    }
}
