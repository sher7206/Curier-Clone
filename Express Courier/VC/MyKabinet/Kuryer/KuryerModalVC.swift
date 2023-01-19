//
//  KuryerModalVC.swift
//  Express Courier
//
//  Created by Sherzod on 11/01/23.
//

import UIKit

class KuryerModalVC: UIViewController {
    
    
    @IBOutlet weak var containerView: UIView!
    
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
    
    @IBAction func submitTapped(_ sender: UIButton) {
        
        let vc = KuryerVC()
        let naVc = UINavigationController.init(rootViewController: vc)
        naVc.modalPresentationStyle = .overFullScreen
        present(naVc, animated: true)
        
    }
}
