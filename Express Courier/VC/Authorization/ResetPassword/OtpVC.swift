
//  OtpVC.swift
//  100KShop
//  Created by MacBook Pro on 24/07/22.


import UIKit

class OtpVC: UIViewController {
    
    @IBOutlet weak var textLbl: UILabel!
    
    @IBOutlet weak var otpTF: OTPFieldView! {
        didSet {
            
            otpTF.fieldsCount = 6
            otpTF.fieldBorderWidth = 1
            //            otpTF.defaultBorderColor = UIColor.lightGray
            otpTF.filledBorderColor = UIColor(named: "success300")!
            otpTF.cursorColor = UIColor(named: "success300")!
            otpTF.textColor = UIColor(named: "success300")!
            //     otpTF.displayType = .underlinedBottom
            otpTF.errorBorderColor = .red
            otpTF.fieldSize = (UIScreen.main.bounds.width-90)/6
            otpTF.otpInputType = .numeric
            otpTF.separatorSpace = 10
            otpTF.shouldAllowIntermediateEditing = false
            otpTF.delegate = self
            otpTF.initializeUI()
        }
    }
    
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var sentBtn: UIButton!{
        didSet{
            //            sentBtn.setTitle(SetLanguage.setLang(type: .sentBtn), for: .normal)
        }
    }
    @IBOutlet weak var smsKodLbl: UILabel!{
        didSet{
            //            smsKodLbl.text = SetLanguage.setLang(type: .dateSMS)
        }
    }
    
    var numberForLbl = ""
    var number = ""
    var otp = ""
    var duration = 120
    var username: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerSetUp()
        //        textLbl.attributedText = "\(SetLanguage.setLang(type: .youLbl)) \(numberForLbl) \(SetLanguage.setLang(type: .confirmKodText))".withYellowText(text: numberForLbl)
        textLbl.text = " \(number) Telefon raqamiga parolni tiklash SMS kod yuborildi"
    }
    
    func timerSetUp() {
        _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [self] t in
            duration = duration - 1
            if duration == 0 {
                timerLbl.text = "00 : 00"
            } else {
                timerLbl.text = "0\(duration/60) : \(duration%60)"
            }
        })
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        print(otp)
        Loader.start()
        let verifyCode = AuthService()
        verifyCode.verifyCode(model: VerifyCodeRequest(username: username, code: otp)) { result in
            switch result {
            case.success(let content):
                Loader.stop()
                guard let token = content.data else {return}
                UserDefaults.standard.set("Bearer " + token, forKey: Keys.userToken)
                let vc = ResetPasswordVC()
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            case.failure(let error):
                Loader.stop()
                Alert.showAlert(forState: .error, message: error.localizedDescription, vibrationType: .error)
            }
        }   
    }
    
    @IBAction func dissmisTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
}

//MARK: - OTPFieldViewDelegate -
extension OtpVC: OTPFieldViewDelegate {
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        otp = ""
        return true
    }
    
    func enteredOTP(otp: String) {
        
        self.otp = otp
    }
    
    func hasEnteredAllOTP(hasEnteredAll: Bool) -> Bool {
        true
    }
    
}
//
////MARK: - Nerwork -
//extension OtpVC {
//
//    func sendOtp() {
//        let params: [String:String] = [
//            "username" : number,
//            "password" : otp
//        ]
//        Net.req(urlAPI: "auth/login", method: .post, withLoader: true, params: params) { [self] data,statusCode  in
//            if let data = data {
//                if data["message"].stringValue == "Kod xato kiritildi" {
//                    Alert.showAlert(forState: .error, message: "\(SetLanguage.setLang(type: .codeError))")
//                } else {
//                    UserDefaults.standard.set(data["data"].stringValue, forKey: Keys.access_token)
////                    ChangeRootViewController.change(with: MainTabBarController())
//
//                    if UserDefaults.standard.string(forKey: Keys.checkPromoKod) != "promo"{
//                        UserDefaults.standard.set("user", forKey: Keys.checkPromoKod)
//                    }
//                }
//            }
//        }
//    }
//

//
//}
//
////MARK: - Network -
//extension OtpVC {
//
//    func login() {
//        Net.req(urlAPI: "auth/password", method: .post, withLoader: false, params: ["username":number]) { [self] data,statusCode  in
//            if let data = data {
//                duration = 60
//                timerSetUp()
//
//                sentBtn.backgroundColor = UIColor(named: "yellow_color")
////                sentBtn.setTitle(SetLanguage.setLang(type: .sentBtn), for: .normal)
//
//                if data["username"].stringValue == self.number {
//                    Alert.showAlert(forState: .success, message: data["message"].stringValue)
//                } else {
//                    self.showUnknownAlert()
//                }
//            }
//        }
//    }
//
//    func getFcmToken(){
//
//        var params:[String : Any] = ["device_type":"ios"
//                                     ,"app_id" : "uz.100k.app"]
//
//        if let fcmToken = UserDefaults.standard.string(forKey: Keys.fcmToken){
//            params["device_id"] = fcmToken
//        }
//
////        Net.reqWithToken(urlAPI: "user/set-device-token", method: .post, withLoader: false, params: params) { data, status in
//            print("Keldi")
//        }
//
//    }
//
//
