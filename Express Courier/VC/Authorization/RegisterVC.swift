//
//  RegisterVC.swift
//  Express Courier
//
//  Created by Sherzod on 06/01/23.
//

import UIKit
import SwiftPhoneNumberFormatter

class RegisterVC: UIViewController {
    
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var usernameTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var gmailTf: PhoneFormattedTextField!
    @IBOutlet var tfViews: [UIView]!
    @IBOutlet weak var eyeImg: UIImageView!
    var isShowPassword: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eyeImg.isHidden = true
        gmailTf.delegate = self
        usernameTf.delegate = self
        passwordTf.delegate = self
        self.confirmBtn.setTitleColor(UIColor(named: "primary1000"), for: .normal)
        gmailTf.config.defaultConfiguration = PhoneFormat(defaultPhoneFormat: "+### ## ### ## ##")
        self.confirmBtn.isEnabled = false
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
    
    
    
    @IBAction func confirmBtnTapped(_ sender: UIButton) {
        guard let number = gmailTf.text?.replacingOccurrences(of: " ", with: "") else {return}
        let register = AuthService()
        
        print(number, usernameTf.text!, passwordTf.text!)
        register.register(model: RegisterRequest(
            name: usernameTf.text!,
            phone: number,
            password: passwordTf.text!)) { result in
                switch result {
                case.success(let content):
                    guard let token = content.data else {return}
                    UserDefaults.standard.set("Bearer " + token, forKey: Keys.userToken)
                    let vc = MainTabBarController()
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: true)
                case.failure(let error):
                    Alert.showAlert(forState: .error, message: error.localizedDescription, vibrationType: .error)
                    let vc = MainTabBarController()
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: true)
                }
            }
    }
    
    
    
    @IBAction func openKabinetTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    //    func sendFcmToken(){
    //        let send = AuthService()
    //
    //        if let fcmToken = UserDefaults.standard.string(forKey: Keys.fcmToken){
    //            send.sendFcmToken(model: FcmTokenRequest(fcm_token: fcmToken, platform: "ios", app_id: "uz.100k.express.client")) { result in
    //                switch result{
    //                case.success(let content):
    //                    print(content.message,"🟢")
    //                case.failure(let error):
    //                    print(error.localizedDescription,"🔴")
    //                }
    //            }
    //        }
    //    }
}

extension RegisterVC: UITextFieldDelegate {
    
    // UITextField Delegates
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == gmailTf {
            tfViews[0].layer.borderColor = UIColor.black.cgColor
        } else if textField == usernameTf {
            tfViews[1].layer.borderColor = UIColor.black.cgColor
        } else {
            tfViews[2].layer.borderColor = UIColor.black.cgColor
            eyeImg.isHidden = false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == gmailTf {
            if textField.text! == "" {
                tfViews[0].layer.borderColor = UIColor(named: "black300")?.cgColor
            }
        } else if textField == usernameTf {
            if textField.text! == "" {
                tfViews[1].layer.borderColor = UIColor(named: "black300")?.cgColor
            }
        } else {
            if textField.text! == "" {
                tfViews[2].layer.borderColor = UIColor(named: "black300")?.cgColor
                eyeImg.isHidden = true
            }
        }
        
        if usernameTf.text! != "" && passwordTf.text! != "" && gmailTf.text! != "" {
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
