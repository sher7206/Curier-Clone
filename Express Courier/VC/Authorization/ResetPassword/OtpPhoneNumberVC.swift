//
//  ResetPasswordVC.swift
//  Express Courier
//
//  Created by Sherzod on 18/01/23.
//

import UIKit
import SwiftPhoneNumberFormatter

class OtpPhoneNumberVC: UIViewController {
    
    
    @IBOutlet weak var tfView: UIView!
    @IBOutlet weak var userNameTf: PhoneFormattedTextField!
    @IBOutlet weak var confirmBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTf.delegate = self
        tfView.layer.borderWidth = 1
        tfView.layer.borderColor = UIColor(named: "black300")?.cgColor
        userNameTf.config.defaultConfiguration = PhoneFormat(defaultPhoneFormat: "+### ## ### ## ##")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
    }
    
    
    @IBAction func confirmBtnTapped(_ sender: UIButton) {
        guard var phoneNumber = userNameTf.text else {return}
        phoneNumber = phoneNumber.filter({$0 != " "})
        Loader.start()
        let resetPassword = AuthService()
        resetPassword.resetPassword(model: ResetPasswordRequest(username: phoneNumber)) { result in
            switch result {
            case.success:
                Loader.stop()
                let vc = OtpVC()
                vc.modalPresentationStyle = .overFullScreen
                vc.number = self.userNameTf.text!
                vc.username = phoneNumber
                self.present(vc, animated: true)
            case.failure(let error):
                Loader.stop()
                Alert.showAlert(forState: .error, message: error.localizedDescription, vibrationType: .error)
            }
        }
        
    }

    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}


//MARK: - Text Field Delegate
extension OtpPhoneNumberVC: UITextFieldDelegate {
    
    // UITextField Delegates
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tfView.layer.borderColor = UIColor.black.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text! == "" {
            tfView.layer.borderColor = UIColor(named: "black300")?.cgColor
        }
        if userNameTf.text! != "" {
            self.confirmBtn.isEnabled = true
            self.confirmBtn.backgroundColor = UIColor(named: "primary900")
            self.confirmBtn.setTitleColor(.black, for: .normal)
        } else {
            self.confirmBtn.isEnabled = false
            self.confirmBtn.backgroundColor = UIColor(named: "primary400")
            self.confirmBtn.setTitleColor(UIColor(named: "primary1000"), for: .normal)
        }
    }
}


