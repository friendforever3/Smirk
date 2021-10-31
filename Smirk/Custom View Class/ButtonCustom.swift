

import Foundation
import UIKit

@IBDesignable
class ButtonCustom: UIButton {
    
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
    
    @IBInspectable var isImageFill:Bool = false{
        didSet {
            
            self.imageView?.contentMode = .scaleAspectFill
        
        }
        
    }
    
    @IBInspectable var isShadow:Bool = false{
        didSet {
        if(!isShadow){
            
            layer.shadowColor = UIColor.clear.cgColor
            layer.shadowOffset = .zero
            layer.shadowOpacity = 0
            layer.masksToBounds = false
            layer.shadowRadius = 0
        }
        else{
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOffset = CGSize(width: shadowWidth, height: shadowHeight)
            layer.shadowOpacity = shadowOpacity
            layer.masksToBounds = false
            layer.shadowRadius = shadowRadius
            
            }
        }
    }
    
    @IBInspectable var shadowWidth:CGFloat = 0{
        
        didSet {
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOffset = CGSize(width: shadowWidth, height: shadowHeight)
            layer.shadowOpacity = shadowOpacity
            layer.masksToBounds = false
            layer.shadowRadius = shadowRadius
        }
        
    }
    @IBInspectable var shadowHeight:CGFloat = 0{
        
        didSet {
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOffset = CGSize(width: shadowWidth, height: shadowHeight)
            layer.shadowOpacity = shadowOpacity
            layer.masksToBounds = false
            layer.shadowRadius = shadowRadius
        }
    }
    @IBInspectable var shadowOpacity:Float = 0.0{
        
        didSet {
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOffset = CGSize(width: shadowWidth, height: shadowHeight)
            layer.shadowOpacity = shadowOpacity
            layer.masksToBounds = false
            layer.shadowRadius = shadowRadius
        }
    }
    @IBInspectable var shadowColor:UIColor = UIColor.clear{
        didSet {
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOffset = CGSize(width: shadowWidth, height: shadowHeight)
            layer.shadowOpacity = shadowOpacity
            layer.masksToBounds = false
            layer.shadowRadius = shadowRadius
        }
        
    }
    
    @IBInspectable var shadowRadius:CGFloat = 0.0{
        didSet {
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOffset = CGSize(width: shadowWidth, height: shadowHeight)
            layer.shadowOpacity = shadowOpacity
            layer.masksToBounds = false
            layer.shadowRadius = shadowRadius
        }
        
    }
}
