//
//  BranchesVC.swift
//  Express Courier
//
//  Created by Sherzod on 19/01/23.
//

import UIKit

class BranchesVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
    }
    
    func setupNavigation() {
        title = "Filiallar"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "primary900")
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.backButtonTitle = ""
    }
}
