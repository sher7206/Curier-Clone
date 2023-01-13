//
//  DeleteTeamVC.swift
//  Express Courier
//
//  Created by Sherzod on 13/01/23.
//

import UIKit



class DeleteTeamVC: UIViewController {

    @IBOutlet weak var containerView: UIView!
    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.layer.cornerRadius = 25
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        openAnimetion()
    }
    
    @IBAction func dismissBtnTapped(_ sender: UIButton) {
        dismissFunc()
    }
    
    @IBAction func deleteItemTapped(_ sender: UIButton) {
        dismissFunc()
        print("index =", index)
    }
    
}

//MARK: - Funcs
extension DeleteTeamVC {
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
}
