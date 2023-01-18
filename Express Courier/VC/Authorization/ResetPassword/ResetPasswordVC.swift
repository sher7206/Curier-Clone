//
//  ResetPasswordVC.swift
//  Express Courier
//
//  Created by Sherzod on 18/01/23.
//

import UIKit

class ResetPasswordVC: UIViewController {
    
    
    @IBOutlet var tfViews: [UIView]!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var confirmBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTF.delegate = self
        confirmPasswordTF.delegate = self
        self.confirmBtn.isEnabled = false
        self.confirmBtn.setTitleColor(UIColor(named: "primary1000"), for: .normal)
        for i in tfViews {
            i.layer.borderWidth = 1
            i.layer.borderColor = UIColor(named: "black300")?.cgColor
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
    }
    
    
    @IBAction func dissmissTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func submitTapped(_ sender: UIButton) {
        Loader.start()
        let confirmPassword = AuthService()
        confirmPassword.confirmPassword(model: ConfirmPasswordRequest(password: passwordTF.text!, password_confirmation: confirmPasswordTF.text!)) { result in
            switch result {
            case.success(let content):
                Loader.stop()
                print(content)
            case.failure(let error):
                Loader.stop()
                Alert.showAlert(forState: .error, message: error.localizedDescription, vibrationType: .error)
            }
        }
    }
}


//MARK: - Text Field Delegate
extension ResetPasswordVC: UITextFieldDelegate {
    
    // UITextField Delegates
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == passwordTF {
            tfViews[0].layer.borderColor = UIColor.black.cgColor
        } else {
            tfViews[1].layer.borderColor = UIColor.black.cgColor
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == passwordTF {
            if textField.text! == "" {
                tfViews[0].layer.borderColor = UIColor(named: "black300")?.cgColor
            }
        } else {
            if textField.text! == "" {
                tfViews[1].layer.borderColor = UIColor(named: "black300")?.cgColor
            }
        }
        
        if passwordTF.text! != "" && confirmPasswordTF.text! != "" {
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
