//
//  NotificationViewController.swift
//  Express Courier
//
//  Created by Sherzod on 09/01/23.
//

import UIKit

class NotificationViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    func setupNavigation() {
        title = "Bildirishnomalar"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "primary900")
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "NotificationTVC", bundle: nil), forCellReuseIdentifier: "NotificationTVC")
    }
}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTVC", for: indexPath) as? NotificationTVC else {return UITableViewCell()}
        
        return cell
    }
    
}
