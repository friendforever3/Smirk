

import UIKit

class ShadowView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        // corner radius
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = false
        // border
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.black.cgColor

        // shadow
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 4.0
    }

}

@IBDesignable
class ViewCustom: UIView {

    
       @IBInspectable var startColor:   UIColor = .black { didSet { updateColors() }}
       @IBInspectable var endColor:     UIColor = .white { didSet { updateColors() }}
       @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
       @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}
       @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
       @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}
    
    override public class var layerClass: AnyClass { CAGradientLayer.self }

        var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }

        func updatePoints() {
            if horizontalMode {
                gradientLayer.startPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 0, y: 0.5)
                gradientLayer.endPoint   = diagonalMode ? .init(x: 0, y: 1) : .init(x: 1, y: 0.5)
            } else {
                gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
                gradientLayer.endPoint   = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
            }
        }
        func updateLocations() {
            gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
        }
        func updateColors() {
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        }
        override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
            updatePoints()
            updateLocations()
            updateColors()
        }
    
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
    
    @IBInspectable var dropShadow: Bool {
           set{
               if newValue {
                   layer.shadowColor = UIColor.black.cgColor
                   layer.shadowOpacity = 0.4
                   layer.shadowRadius = 1
                   layer.shadowOffset = CGSize.zero
               } else {
                   layer.shadowColor = UIColor.clear.cgColor
                   layer.shadowOpacity = 0
                   layer.shadowRadius = 0
                   layer.shadowOffset = CGSize.zero
               }
           }
           get {
               return layer.shadowOpacity > 0
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
    
    @IBInspectable var shadowRadius:CGFloat = 0.0{
        didSet {
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOffset = CGSize(width: shadowWidth, height: shadowHeight)
            layer.shadowOpacity = shadowOpacity
            layer.masksToBounds = false
            layer.shadowRadius = shadowRadius
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
