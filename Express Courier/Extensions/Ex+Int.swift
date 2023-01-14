//
//  Ex+Int.swift
//  100KShop
//
//  Created by Ramzxon Maxmudov on 14/08/22.
//

import UIKit

extension Double {
    func priceFormetter() -> String {
        var price = String(Int(self))
        var natija = ""
        let qoldiq = price.count % 3
        for index in stride(from: 0, to: price.count - qoldiq, by: 3) {
            var section = price
            section.removeFirst(price.count - 3 - index)
            section.removeLast(index)
            natija = section + " " + natija
        }
        price.removeLast(price.count - qoldiq)
        natija = price + " " + natija
        if natija.hasPrefix(" ") {
            natija.removeFirst()
        }
        if natija.hasSuffix(" ") {
            natija.removeLast()
        }
        return natija
    }
}

extension Int {
    func priceFormetter() -> String {
        var price = String(self)
        var natija = ""
        let qoldiq = price.count % 3
        for index in stride(from: 0, to: price.count - qoldiq, by: 3) {
            var section = price
            section.removeFirst(price.count - 3 - index)
            section.removeLast(index)
            natija = section + " " + natija
        }
        price.removeLast(price.count - qoldiq)
        natija = price + " " + natija
        if natija.hasPrefix(" ") {
            natija.removeFirst()
        }
        if natija.hasSuffix(" ") {
            natija.removeLast()
        }
        return natija
    }
}

extension UIBarButtonItem {
    
    convenience init(icon: UIImage, badge: String, _ badgeBackgroundColor: UIColor = #colorLiteral(red: 0.9156965613, green: 0.380413115, blue: 0.2803866267, alpha: 1), target: Any? = UIBarButtonItem.self, action: Selector? = nil) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        imageView.image = icon
        
        let label = UILabel(frame: CGRect(x: -8, y: -5, width: 18, height: 18))
        label.text = badge
        label.backgroundColor = badgeBackgroundColor
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.clipsToBounds = true
        label.layer.cornerRadius = 18 / 2
        label.textColor = .white
        let buttonView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        buttonView.addSubview(imageView)
        buttonView.addSubview(label)
        buttonView.addGestureRecognizer(UITapGestureRecognizer.init(target: target, action: action))
        self.init(customView: buttonView)
    }
    
}

