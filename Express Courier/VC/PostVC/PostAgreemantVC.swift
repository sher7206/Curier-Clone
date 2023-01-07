
//  PostAgreemantVC.swift
//  Express Courier
//  Created by apple on 07/01/23.

import UIKit

class PostAgreemantVC: UIViewController {

    @IBOutlet weak var backView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openAnimetion()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backView.roundCorners(corners: [.topLeft, .topRight], radius: 25)
        backView.clipsToBounds = true
    }

    
    func openAnimetion() {
        Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { _ in
            UIView.animate(withDuration: 0.4) {
                self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            }
        }
    }

    func dismissFunc() {
        self.view.backgroundColor = .clear
        self.dismiss(animated: true)
    }

    @IBAction func dissmissBtnPressed(_ sender: Any) {
        dismissFunc()
    }
    
    @IBAction func agreemantBtnPressed(_ sender: Any) {
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismissFunc()
    }
    
    
}
