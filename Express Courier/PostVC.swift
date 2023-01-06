//
//  PostVC.swift
//  Express Courier
//
//  Created by apple on 05/01/23.
//

import UIKit

class PostVC: UIViewController {

    @IBOutlet weak var fromRegionLbl: UILabel!
    @IBOutlet weak var toRegionLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        title = "Pochta"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "primary900")
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func setupNavigation(){
        let menuBtn = UIBarButtonItem(image: UIImage(named: "menu-list"), style: .plain, target: self, action: #selector(menuBtnPressed))
        navigationItem.leftBarButtonItem = menuBtn
        let filterBtn = UIBarButtonItem(image: UIImage(named: "filter-post"), style: .plain, target: self, action: #selector(filterBtnPressed))
        navigationItem.rightBarButtonItem = filterBtn
    }
    
    @objc func menuBtnPressed(){
        let vc = SideMenuVC(nibName: "SideMenuVC", bundle: nil)
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overFullScreen
        present(nav, animated: false, completion: nil)
    }
    
    
    @objc func filterBtnPressed(){
        
    }
    
    
    @IBAction func fromButtonPressed(_ sender: Any) {
    }
    @IBAction func toButtonPressed(_ sender: Any) {
    }
    @IBAction func fromDismissBtnPressed(_ sender: Any) {
    }
    @IBAction func toDismissBtnPressed(_ sender: Any) {
    }
    @IBAction func exchangeBtnPressed(_ sender: Any) {
    }

    
}
