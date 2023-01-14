//
//  ListVC.swift
//  Express Courier
//
//  Created by Sherzod on 13/01/23.
//

import UIKit

class ListVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MEN Umarov
        setupNavigation()
    }
    
    func setupNavigation() {
        title = "Ro'yhatlar"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "primary900")
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.backButtonTitle = ""
    }
    
}
