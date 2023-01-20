//
//  LockScreenVC.swift
//  Express Courier
//
//  Created by Sherzod on 20/01/23.
//

import UIKit

class LockScreenVC: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet var textImages: [UIImageView]!
    @IBOutlet var numberImages: [UIImageView]!
    @IBOutlet weak var kodView: UIView!
    
    var numberCount: Int = 0
    var code: String = ""
    var saveCode: String = "1234"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.numberImages.forEach({$0.image = UIImage(named: "unselectNumber")})
    }
    
    @IBAction func numberSelect(_ sender: UIButton) {
        for i in numberImages {
            i.image = UIImage(named: "unselectNumber")
        }
        numberImages[sender.tag].image = UIImage(named: "selectNumber")
        self.numberCount += 1
        
        if self.numberCount <= 4 || self.numberCount > 0 {
            self.code = code + "\(sender.tag)"
            for i in textImages {
                i.image = UIImage(named: "noText")
            }
            for i in 0..<numberCount {
                textImages[i].image = UIImage(named: "yesText")
            }
            
            if self.numberCount == 4 {
                if self.code == Cache.share.getUserPassword() {
                    let vc = MainTabBarController()
                    guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
                    window.rootViewController = vc
                    window.makeKeyAndVisible()
                    let options: UIView.AnimationOptions = .transitionCrossDissolve
                    let duration: TimeInterval = 0.3
                    UIView.transition(with: window, duration: duration, options: options, animations: {
                    }, completion:{completed in})
                } else {
                    kodView.shake()
                    self.titleLbl.text = "PIN kodni qayta kiriting"
                    Alert.showAlert(forState: .error, message: "PIN kod xato", vibrationType: .error)
                    self.numberCount = 0
                    self.code = ""
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: {
                        self.numberImages.forEach({$0.image = UIImage(named: "unselectNumber")})
                        self.textImages.forEach({$0.image = UIImage(named: "noText")})
                    })
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
