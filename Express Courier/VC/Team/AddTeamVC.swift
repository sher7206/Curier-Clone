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
    var regionId: Int = 0
    var districtId: Int = 0
    
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
    
    @IBAction func openRegionTapped(_ sender: UIButton) {
        let vc = RegionsVC()
        vc.vc = self
        self.present(vc, animated: true)
    }
    
    
    @IBAction func submitBtnTapped(_ sender: UIButton) {
       
        Loader.start()
        let addTeam = TeamService()
        guard var phoneNumber = phoneTF.text else {return}
        phoneNumber = phoneNumber.replacingOccurrences(of: " ", with: "")
        addTeam.addTeam(model: AddTeamRequest(username: phoneNumber, name: fullNameTf.text!, region_id: regionId, district_id: districtId)) { result in
            switch result {
            case.success(let content):
                Loader.stop()
                self.dismissFunc()
                self.delegate?.addTeam()
                print("✅ content =", content)
            case.failure(let error):
                Loader.stop()
                print(error.localizedDescription)
                Alert.showAlert(forState: .error, message: error.localizedDescription, vibrationType: .error)
            }
        }
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

extension AddTeamVC: RegionSelectedVCDelegate {
    func setLocatoin(region id: Int, regoin name: String, state: States, isToRegion: Bool) {
        self.locationTf.text! = name + ", " + state.name
        self.regionId = id
        self.districtId = state.id ?? 0
    }
}
