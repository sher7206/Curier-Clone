//
//  Ex+UIView.swift
//  Ark Buloq
//
//  Created by Ramzxon Maxmudov on 16/06/21.
//

import UIKit

extension UIView {

    func addShadow(offset: CGSize = CGSize(width: 3, height: 3), color: UIColor = .black, radius: CGFloat = 5, opacity: Float = 1) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity

        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor = backgroundCGColor
    }
    func addShadow2(offset: CGSize = CGSize(width: 3, height: 3), color: UIColor = .black, radius: CGFloat = 5, opacity: Float = 1) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }

    
    func addDashedBorder(_ color: UIColor = UIColor.black, withWidth width: CGFloat = 1, cornerRadius: CGFloat = 4, dashPattern: [NSNumber] = [2, 2]) {

      let shapeLayer = CAShapeLayer()

      shapeLayer.bounds = bounds
      shapeLayer.position = CGPoint(x: bounds.width/2, y: bounds.height/2)
      shapeLayer.fillColor = nil
      shapeLayer.strokeColor = color.cgColor
      shapeLayer.lineWidth = width
      shapeLayer.lineJoin = CAShapeLayerLineJoin.round
      shapeLayer.lineDashPattern = dashPattern
      shapeLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath

      self.layer.addSublayer(shapeLayer)
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }

    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}

extension UIView {
    
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
       
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
       
        let mask = CAShapeLayer()
         mask.path = path.cgPath
        layer.mask = mask
    
    }
    
    func pulsate() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.2
        pulse.fromValue = 0.90
        pulse.toValue = 1.0
        pulse.autoreverses = false
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.7
        pulse.damping = 1.0
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()

        layer.add(pulse, forKey: "pulse")
    }

}

extension UIView {
    
    func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        return self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
    
    func applyGradientHorizontal(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
    
    func fadeIn(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
            self.isHidden = false
            self.alpha = 1.0
    }

    func fadeOut(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in }) {
            self.isHidden = true
            self.alpha = 0.0
    }
    
}


