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
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var contView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contViews[0].backgroundColor = UIColor(named: "primary200")
        contView.transform = .init(translationX: -contView.frame.width, y: 0)
        blurView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 0.288016414)
        blurView.alpha = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sideMenuAnimation()
    }
    
    func sideMenuAnimation(){
        navigationController?.navigationBar.isHidden = true
        UIView.animate(withDuration: 0.3) { [self] in
            self.contView.transform = .identity
            blurView.alpha = 1
        }
    }

    
    @IBAction func itemBtnPressed(_ sender: UIButton) {
        for i in contViews{
            i.backgroundColor = .white
        }
        contViews[sender.tag].backgroundColor = UIColor(named: "primary200")
    }
    
    @IBAction func dismissBtnPressed(_ sender: Any) {
        UIView.animate(withDuration: 0.3) { [self] in
            self.contView.transform = .init(translationX: -self.contView.frame.width, y: 0)
            blurView.alpha = 0
        }completion: { _ in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    
    
}
