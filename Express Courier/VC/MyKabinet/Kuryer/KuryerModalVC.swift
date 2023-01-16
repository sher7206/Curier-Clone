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
    }
    
    @IBAction func dismissBtnTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func submitTapped(_ sender: UIButton) {
        
        let vc = KuryerVC()
        let naVc = UINavigationController.init(rootViewController: vc)
        naVc.modalPresentationStyle = .overFullScreen
        present(naVc, animated: true)
        
    }
    
    
}
