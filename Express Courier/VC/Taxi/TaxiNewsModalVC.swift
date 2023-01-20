//
//  TaxiNewsModalVC.swift
//  Express Courier
//
//  Created by Sherzod on 12/01/23.
//

import UIKit

protocol TaxiNewsModalVCDelegate {
    func callTapped()
}

class TaxiNewsModalVC: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    var delegate: TaxiNewsModalVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.layer.cornerRadius = 25
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        openAnimetion()
        
    }
    
    func openAnimetion() {
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
            UIView.animate(withDuration: 0.3) {
                self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            }
        }
    }
    
    func dismissFunc() {
        self.view.backgroundColor = .clear
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: false) { _ in
            UIView.animate(withDuration: 0.05) {
                self.dismiss(animated: true)
            }
        }
    }
    
    @IBAction func dismissBtnTapped(_ sender: UIButton) {
        dismissFunc()
    }
    
    @IBAction func callBtnTapped(_ sender: UIButton) {
        self.delegate?.callTapped()
        
        
        let number = "+998999757206"
        guard let number = URL(string: "tel://" + number) else { return }
        UIApplication.shared.open(number)
        
    }
    
}


