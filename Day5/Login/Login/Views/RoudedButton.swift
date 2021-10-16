//
//  RoudedButton.swift
//  Login
//
//  Created by Bayu Yasaputro on 04/10/21.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    @IBInspectable
    var cornerRadius: CGFloat = 20
    
    @IBInspectable
    var height: CGFloat = 40
    
    weak var heightConstraint: NSLayoutConstraint?
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: height)
        ])
        
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = cornerRadius > 0
    }
}
