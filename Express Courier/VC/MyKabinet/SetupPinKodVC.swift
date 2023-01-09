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
    
    var numberCount: Int = 0
    var firstNumber: String = ""
    var secondNumber: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            self.firstNumber = firstNumber + "\(sender.tag)"
        }
    }
    
    @IBAction func clearBtnTapped(_ sender: UIButton) {
        
        
    }
}
