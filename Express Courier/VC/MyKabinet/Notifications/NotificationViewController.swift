//
//  NotificationViewController.swift
//  Express Courier
//
//  Created by Sherzod on 09/01/23.
//

import UIKit

class NotificationViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    var dates: [GetNotificationsData] = []
    var currentPage: Int = 1
    var totalItems: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        uploadData(page: currentPage)
    }
    
    func uploadData(page: Int) {
        Loader.start()
        let getNotification = UserService()
        getNotification.getNotifications(model: GetNotificationsRequest(page: page)) { result in
            switch result {
            case.success(let content):
                Loader.stop()
                guard let data = content.data else {return}
                self.dates.append(contentsOf: data)
                self.totalItems = content.meta?.total ?? 0
                self.tableView.reloadData()
            case.failure(let error):
                Alert.showAlert(forState: .error, message: error.localizedDescription, vibrationType: .error)
                Loader.stop()
            }
        }
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
        return dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTVC", for: indexPath) as? NotificationTVC else {return UITableViewCell()}
        cell.updateCell(data: self.dates[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == dates.count - 1 {
            if totalItems > dates.count {
                currentPage += 1
                uploadData(page: currentPage)
                self.tableView.reloadData()
            }
        }
    }
    
    
}
