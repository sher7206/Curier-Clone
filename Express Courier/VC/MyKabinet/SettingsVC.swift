//
//  SettingsVC.swift
//  Express Courier
//
//  Created by Sherzod on 07/01/23.
//

import UIKit

class SettingsVC: UIViewController {
    
    
    @IBOutlet var langImage: [UIImageView]!
    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var lastNameTf: UITextField!
    @IBOutlet weak var regionTf: UITextField!
    @IBOutlet weak var districtTf: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
    }
    
    func setupNavigation() {
        title = "Ma’lumotlarni o‘zgaritirish"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "primary900")
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        langImage[0].image = UIImage(named: "radiobutton-checked-my")
        
        
    }
    
    
    @IBAction func regionSelectTapped(_ sender: UIButton) {
        
        
    }
    
    
    @IBAction func languageBtnTapped(_ sender: UIButton) {
        for i in langImage {
            i.image = UIImage(named: "radiobutton-unchecked-my")
        }
        langImage[sender.tag].image = UIImage(named: "radiobutton-checked-my")
        
    }
}
