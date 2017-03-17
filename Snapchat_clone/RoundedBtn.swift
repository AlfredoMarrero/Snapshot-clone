//
//  RoundedBtn.swift
//  Snapchat_clone
//
//  Created by Alfredo M. on 3/17/17.
//  Copyright © 2017 Alfredo M. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedBtn: UIButton{

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var bgColor: UIColor? {
        didSet {
            backgroundColor = bgColor
        }
    }

}
