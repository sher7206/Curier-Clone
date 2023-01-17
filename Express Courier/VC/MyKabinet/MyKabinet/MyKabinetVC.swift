//
//  MyKabinetVC.swift
//  Express Courier
//
//  Created by Sherzod on 06/01/23.
//

import UIKit

class MyKabinetVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    var categoryDates: [MyKabinetCategoryDM] = [
        
        MyKabinetCategoryDM(name: "To‘lo‘vlar tarixi", imgName: "money-time-my"),
        MyKabinetCategoryDM(name: "Hisobni to‘ldirish", imgName: "wallet-add-my"),
        MyKabinetCategoryDM(name: "Bildirishnomalar", imgName: "notification-bing-my"),
        MyKabinetCategoryDM(name: "Kuryer bo‘lish", imgName: "courier-my"),
        MyKabinetCategoryDM(name: "Sozlamalar", imgName: "user-edit-my"),
        MyKabinetCategoryDM(name: "Pin kod qo‘yish", imgName: "lock-my"),
        MyKabinetCategoryDM(name: "Yangiliklar", imgName: "newsKabinet"),
        MyKabinetCategoryDM(name: "Dastur xaqida", imgName: "infoKabinet"),
        MyKabinetCategoryDM(name: "Murojat qilish", imgName: "24-support"),
        MyKabinetCategoryDM(name: "Akkauntdan chiqish", imgName: "logout-my")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(send: UIRefreshControl) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    func setupNavigation() {
        navigationItem.title = "Mening kabinetim"
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
        uploadData()
    }
    
    func uploadData() {
        Loader.start()
        let getMe = UserService()
        getMe.getMe { result in
            switch result {
            case.success(let content):
                guard let data = content.data else {return}
                Loader.stop()
                Cache.saveUser(user: UserDM(id: data.id, name: data.name, surname: data.surname, email: data.email, phone: data.phone, balance: data.balance, rating: data.rating, region_id: data.region_id, region_name: data.region_name, district_id: data.district_id, district_name: data.district_name, detail_address: data.detail_address, roles: data.roles, avatar: data.avatar, created_at: data.created_at, created_at_label: data.created_at_label))
                self.tableView.reloadData()
            case.failure(let error):
                Loader.stop()
                Alert.showAlert(forState: .error, message: error.localizedDescription, vibrationType: .error)
            }
        }
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
            return categoryDates.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyInfoTVC", for: indexPath) as? MyInfoTVC else {return UITableViewCell()}
            cell.updateCell(data: Cache.getUser())
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCategoryTVC", for: indexPath) as? MyCategoryTVC else {return UITableViewCell()}
            cell.updateCell(dates: categoryDates, index: indexPath.row)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            if indexPath.row == 3 {
                return UITableView.automaticDimension
            } else {
                return UITableView.automaticDimension
            }
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                let vc = PaymentHistoryVC()
                vc.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 1 {
                let vc = PayAccountVC()
                vc.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 2 {
                let vc = NotificationViewController()
                vc.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 3 {
                let vc = KuryerModalVC()
                vc.modalPresentationStyle = .overFullScreen
                present(vc, animated: true)
            } else if indexPath.row == 4 {
                let vc = SettingsVC()
                vc.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 5 {
                let vc = PinkodVC()
                vc.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 6 {
                let vc = NewsVC()
                vc.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 7 {
                let vc = AboutAppVC()
                vc.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 9 {
                showAlert(withTitle: "Chiqish", withMessage: "Profildan chiqishni hohlaysizmi?")
            }
        }
    }
}

extension MyKabinetVC {
    
    func showAlert(withTitle title: String, withMessage message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ha, chiqish", style: .default, handler: { action in
            Loader.start()
            let logOut = UserService()
            logOut.logOut { resut in
                switch resut {
                case.success(let content):
                    Loader.stop()
                    print(content)
                    Cache.saveUser(user: nil)
                    UserDefaults.standard.set(nil, forKey: Keys.userToken)
                    self.tableView.reloadData()
                case.failure(let error):
                    Loader.stop()
                    Alert.showAlert(forState: .error, message: error.localizedDescription, vibrationType: .error)
                }
            }
        })
        let cancel = UIAlertAction(title: "Yo'q, ortga", style: .destructive, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
}