//
//  SetupPinKodVC.swift
//  Express Courier
//
//  Created by Sherzod on 07/01/23.
//

import UIKit

class SetupPinKodVC: UIViewController {
    
    
    @IBOutlet var textImages: [UIImageView]!
    @IBOutlet var numberImages: [UIImageView]!
    @IBOutlet weak var kodView: UIView!
    var confirmCode: String = ""
    var second: Bool = false
    
    
    var numberCount: Int = 0
    var code: String = ""
    var secondNumber: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.code = ""
        for i in numberImages {
            i.image = UIImage(named: "unselectNumber")
        }
        setupNavigation()
    }
    
    func setupNavigation() {
        title = "Pin kod o‘rnatish"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "primary900")
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    
    @IBAction func numberSelect(_ sender: UIButton) {
        
        for i in numberImages {
            i.image = UIImage(named: "unselectNumber")
        }
        numberImages[sender.tag].image = UIImage(named: "selectNumber")
        
        self.numberCount += 1
        
        if self.numberCount <= 4 {
            for i in textImages {
                i.image = UIImage(named: "noText")
            }
            
            for i in 0..<numberCount {
                textImages[i].image = UIImage(named: "yesText")
            }
            self.code = code + "\(sender.tag)"
            
            if self.numberCount == 4 {
                if second {
                    
                    if confirmCode == code {
                        
                        
                    } else {
                        kodView.shake()
                        self.numberCount = 0
                        self.code = ""
                        self.confirmCode = ""
                        second = false
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3, execute: {
                        self.numberImages.forEach({$0.image = UIImage(named: "unselectNumber")})
                        self.textImages.forEach({$0.image = UIImage(named: "noText")})
                    })
                } else {
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3, execute: {
                        self.numberImages.forEach({$0.image = UIImage(named: "unselectNumber")})
                        self.textImages.forEach({$0.image = UIImage(named: "noText")})
                    })
                    self.numberCount = 0
                    self.confirmCode = code
                    self.code = ""
                    second = true
                }
            }
            
        }
    }
    
    @IBAction func clearBtnTapped(_ sender: UIButton) {
        self.numberCount -= 1
        if numberCount >= 0 {
            self.textImages.forEach({$0.image = UIImage(named: "noText")})
            for i in 0..<numberCount {
                textImages[i].image = UIImage(named: "yesText")
            }
            self.code = String(code.dropLast())
        }
    }
}


extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-40.0, 40.0, -30.0, 30.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}
