//
//  SideMenuVC.swift
//  Express Courier
//
//  Created by apple on 05/01/23.
//

import UIKit

class SideMenuVC: UIViewController {

    
    
    @IBOutlet weak var userBalanceLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    
    @IBOutlet var contViews: [UIView]!
    @IBOutlet var sideImages: [UIImageView]!
    @IBOutlet var sideNamesLbls: [UILabel]!
    var sideTexts = ["Pochta","Filliallar","Jamoa","Taksi","Yangiliklar","Dastur xaqida","Dastur xaqida"]
    var sideImgs = ["box-menu","building-menu","people-menu","car-menu","notification-status-menu","info-circle-menu","24-support-menu"]

    override func viewDidLoad() {
        super.viewDidLoad()
        contViews[0].backgroundColor = UIColor(named: "primary200")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for i in 0...sideImgs.count-1{
            sideImages[i].image = UIImage(named: sideImgs[i])
            sideNamesLbls[i].text = sideTexts[i]
        }
    }
    
    @IBAction func itemBtnPressed(_ sender: UIButton) {
        for i in contViews{
            i.backgroundColor = .white
        }
        contViews[sender.tag].backgroundColor = UIColor(named: "primary200")
    }
    
    
    
}
