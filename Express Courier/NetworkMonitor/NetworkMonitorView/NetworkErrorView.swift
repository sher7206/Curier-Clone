//
//  ErrorView.swift
//  100kExpress
//
//  Created by Sherzod on 24/01/23.
//

import UIKit

class NetworkErrorView {
    
    ///Shows custom Alert for a while
    class func start() {
        
        let loadV = UIView()
        loadV.backgroundColor = #colorLiteral(red: 1, green: 0.7612915635, blue: 0, alpha: 1)
        loadV.tag = 2023
        loadV.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        let stack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.alignment = .center
            stack.distribution = .equalSpacing
            return stack
        }()
        
        let imgV: UIImageView = {
            let img = UIImageView()
            img.image = UIImage(systemName: "wifi.slash")
            img.tintColor = .white
            img.contentMode = .scaleAspectFit
            return img
        }()
        
        let lbl: UILabel = {
            let lbl = UILabel()
            lbl.text = "Sizda internet bilan bog'liq muammo mavjud!"
            lbl.textAlignment = .center
            lbl.numberOfLines = 2
            lbl.textColor = .white
            return lbl
        }()
        
        loadV.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.leadingAnchor.constraint(equalTo: loadV.leadingAnchor, constant: 20).isActive = true
        stack.trailingAnchor.constraint(equalTo: loadV.trailingAnchor, constant: -20).isActive = true
        stack.centerYAnchor.constraint(equalTo: loadV.centerYAnchor).isActive = true
        imgV.translatesAutoresizingMaskIntoConstraints = false
        imgV.heightAnchor.constraint(equalToConstant: 180).isActive = true
        imgV.widthAnchor.constraint(equalToConstant: 200).isActive = true
        stack.addArrangedSubview(imgV)
        stack.addArrangedSubview(lbl)
        
        if let view = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
            view.addSubview(loadV)
        }
    }
    
    class func stop() {
        DispatchQueue.main.async {
            for i in UIApplication.shared.keyWindow!.subviews {
                if i.tag == 2023 {
                    i.removeFromSuperview()
                }
            }
        }
    }
}
