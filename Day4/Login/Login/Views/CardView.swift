//
//  CardView.swift
//  Login
//
//  Created by Bayu Yasaputro on 04/10/21.
//

import UIKit

@IBDesignable
class CardView: UIView {
    weak var shadowLayer: CAShapeLayer!
    
    @IBInspectable
    var cornerRadius: CGFloat = 0
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            let shadowLayer = CAShapeLayer()
            layer.insertSublayer(shadowLayer, at: 0)
            self.shadowLayer = shadowLayer
        }
        
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        shadowLayer?.fillColor = UIColor.white.cgColor
        shadowLayer?.path = path.cgPath
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        shadowLayer?.shadowColor = UIColor.darkGray.cgColor
        shadowLayer?.shadowPath = shadowPath.cgPath
        shadowLayer?.shadowOffset = CGSize(width: 0, height: 1)
        shadowLayer?.shadowOpacity = 0.2
        shadowLayer?.shadowRadius = 3
    }
    
    func setup() {
        backgroundColor = .clear
    }
}
