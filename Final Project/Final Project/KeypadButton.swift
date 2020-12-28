//
//  KeypadButton.swift
//  Final Project
//
//  Created by Tan Jingsong on 7/24/20.
//  Copyright © 2020 Tan Jingsong. All rights reserved.
//

import UIKit

@IBDesignable
class KeypadButton: UIButton {
    
    @IBInspectable var highlightBackgroundColor: UIColor = .white
    @IBInspectable var defaultBackgroundColor: UIColor = .white {
        didSet {
            backgroundColor = defaultBackgroundColor
        }
    }

    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? highlightBackgroundColor : defaultBackgroundColor
        }
    }

}
