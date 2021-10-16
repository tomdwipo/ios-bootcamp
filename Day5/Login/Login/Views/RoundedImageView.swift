//
//  RoundedImageView.swift
//  Login
//
//  Created by Bayu Yasaputro on 06/10/21.
//

import UIKit

@IBDesignable
class RoundedImageView: UIImageView {
    @IBInspectable
    var cornerRadius: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    func setup() {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
}
