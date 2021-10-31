
import Foundation


import UIKit

@IBDesignable
class LabelCustom: UILabel {
    
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
    
    @IBInspectable var isRound: Bool = false {
        didSet {
            if(isRound){
                
                layer.cornerRadius = self.frame.height/2
                layer.masksToBounds = true
            }
        }
    }
    
    
}
