//
//  MyKabinetVC.swift
//  Express Courier
//
//  Created by Sherzod on 06/01/23.
//

import UIKit

class MyKabinetVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var categoryDates: [MyKabinetCategoryDM] = [
        
        MyKabinetCategoryDM(name: "To‘lo‘vlar tarixi", imgName: "money-time-my"),
        MyKabinetCategoryDM(name: "Hisobni to‘ldirish", imgName: "wallet-add-my"),
        MyKabinetCategoryDM(name: "Bildirishnomalar", imgName: "notification-bing-my"),
        MyKabinetCategoryDM(name: "Kuryer bo‘lish", imgName: "courier-my"),
        MyKabinetCategoryDM(name: "Sozlamalar", imgName: "user-edit-my"),
        MyKabinetCategoryDM(name: "Pin kod qo‘yish", imgName: "lock-my"),
        MyKabinetCategoryDM(name: "Akkauntdan chiqish", imgName: "logout-my")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
    }
    
    func setupNavigation() {
        title = "Mening kabinetim"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu-list"), style: .plain, target: self, action: #selector(addTapped))
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "primary900")
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.backButtonTitle = ""
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MyInfoTVC", bundle: nil), forCellReuseIdentifier: "MyInfoTVC")
        tableView.register(UINib(nibName: "MyCategoryTVC", bundle: nil), forCellReuseIdentifier: "MyCategoryTVC")
    }
    
    @objc func addTapped() {
        print("Left")
    }
    
}

extension MyKabinetVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 7
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyInfoTVC", for: indexPath) as? MyInfoTVC else {return UITableViewCell()}
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCategoryTVC", for: indexPath) as? MyCategoryTVC else {return UITableViewCell()}
            cell.updateCell(dates: categoryDates, index: indexPath.row)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = PaymentHistoryVC()
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 1 {
            let vc = PayAccountVC()
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 2 {
            let vc = NotificationViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 4 {
            let vc = SettingsVC()
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 5 {
            let vc = PinkodVC()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

