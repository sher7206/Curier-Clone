//
//  PinkodVC.swift
//  Express Courier
//
//  Created by Sherzod on 07/01/23.
//

import UIKit

class PinkodVC: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var submitBtnTitle: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    func setupNavigation() {
        let password = Cache.share.getUserPassword()
        title = "Pin kod"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "primary900")
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.backButtonTitle = ""
        self.deleteView.isHidden = true
        self.titleLbl.text = "Siz ilovaga kirish uchun PIN - kod o‘rnatmagansiz "
        if password != nil {
            self.deleteView.isHidden = false
            self.titleLbl.text = "Sizning havfsizligingiz uchun"
            self.submitBtnTitle.text = "PIN - kodni o'zgartirish"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let password = Cache.share.getUserPassword()
        self.deleteView.isHidden = true
        self.titleLbl.text = "Siz ilovaga kirish uchun PIN - kod o‘rnatmagansiz "
        if password != nil {
            self.deleteView.isHidden = false
            self.titleLbl.text = "Sizning havfsizligingiz uchun"
            self.submitBtnTitle.text = "PIN - kodni o'zgartirish"
        }
    }
    
    @IBAction func setupPinTapped(_ sender: UIButton) {
        let vc = SetupPinKodVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func deletePinTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        UserDefaults.standard.set(nil, forKey: Keys.userPassword)
    }
}
