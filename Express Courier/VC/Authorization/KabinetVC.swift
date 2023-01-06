//
//  KabinetVC.swift
//  Express Courier
//
//  Created by Sherzod on 06/01/23.
//

import UIKit

class KabinetVC: UIViewController {
    
    
    
    
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var usernameTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet var tfViews: [UIView]!
    @IBOutlet weak var eyeImg: UIImageView!
    var isShowPassword: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eyeImg.isHidden = true
        usernameTf.delegate = self
        passwordTf.delegate = self
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
    
    
    
    @IBAction func showPasswordTapped(_ sender: UIButton) {
        if isShowPassword {
            eyeImg.image = UIImage(systemName: "eye.slash")
            passwordTf.isSecureTextEntry = true
        } else {
            eyeImg.image = UIImage(systemName: "eye")
            passwordTf.isSecureTextEntry = false
        }
        isShowPassword = !isShowPassword
    }
    
    
    @IBAction func registerTapped(_ sender: UIButton) {
        let vc = RegisterVC()
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
    
   
    
}

//MARK: - Text Field Delegate
extension KabinetVC: UITextFieldDelegate {
    
    // UITextField Delegates
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == usernameTf {
            tfViews[0].layer.borderColor = UIColor.black.cgColor
        } else {
            tfViews[1].layer.borderColor = UIColor.black.cgColor
            eyeImg.isHidden = false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == usernameTf {
            if textField.text! == "" {
                tfViews[0].layer.borderColor = UIColor(named: "black300")?.cgColor
            }
        } else {
            if textField.text! == "" {
                tfViews[1].layer.borderColor = UIColor(named: "black300")?.cgColor
                eyeImg.isHidden = true
            }
        }
        
        if usernameTf.text! != "" && passwordTf.text! != "" {
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
