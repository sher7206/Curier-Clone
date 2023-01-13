//
//  AddTeamVC.swift
//  Express Courier
//
//  Created by Sherzod on 13/01/23.
//

import UIKit
import SwiftPhoneNumberFormatter

protocol AddTeamVCDelegate {
    func addTeam()
}

class AddTeamVC: UIViewController {
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var fullNameTf: UITextField!
    @IBOutlet weak var locationTf: UITextField!
    @IBOutlet weak var phoneTF: PhoneFormattedTextField!
    
    var delegate: AddTeamVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.layer.cornerRadius = 25
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        openAnimetion()
        phoneTF.config.defaultConfiguration = PhoneFormat(defaultPhoneFormat: "+### ## ### ## ##")
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(false)
    }
    
    @IBAction func dismissBtnTapped(_ sender: UIButton) {
        dismissFunc()
    }
    
    @IBAction func submitBtnTapped(_ sender: UIButton) {
        self.delegate?.addTeam()
        dismissFunc()
    }
}


//MARK: - Funcs
extension AddTeamVC {
    
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