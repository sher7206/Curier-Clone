//
//  TaxiOldUserModalVC.swift
//  Express Courier
//
//  Created by Sherzod on 12/01/23.
//

import UIKit

class TaxiOldUserModalVC: UIViewController {
    
    @IBOutlet weak var closeView: UIView!
    @IBOutlet weak var containerView: UIView!
    var isClose: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeView.isHidden = true
        containerView.layer.cornerRadius = 25
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        openAnimetion()
        self.closeView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    }
    
    func closeViewOpen() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.closeView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        },completion: { finish in
            UIView.animate(withDuration: 0.5, delay: 0.0,options: UIView.AnimationOptions.curveEaseOut,animations: {
                self.closeView.transform = CGAffineTransform(scaleX: 1, y: 1)
            },completion: nil)})
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
        if isClose {
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.closeView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            } completion: { finish in
                self.closeView.isHidden = true
                self.view.backgroundColor = .clear
                self.dismiss(animated: true)
            }
        } else {
            dismissFunc()
        }
    }
    
    @IBAction func closeBtnTapped(_ sender: UIButton) {
        closeViewOpen()
        closeView.isHidden = false
        containerView.isHidden = true
        self.isClose = true
    }
    
    @IBAction func closeOrderTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, delay: 0) {
            self.closeView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        } completion: { finish in
            self.closeView.isHidden = true
            self.view.backgroundColor = .clear
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, delay: 0) {
            self.closeView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        } completion: { finish in
            self.closeView.isHidden = true
            self.view.backgroundColor = .clear
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func callBtnTapped(_ sender: UIButton) {
        let number = "+998999757206"
        guard let number = URL(string: "tel://" + number) else { return }
        UIApplication.shared.open(number)
    }
    
    
}
