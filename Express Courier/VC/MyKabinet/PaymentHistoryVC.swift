//
//  PaymentHistoryVC.swift
//  Express Courier
//
//  Created by Sherzod on 06/01/23.
//

import UIKit

class PaymentHistoryVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var dates: [GetTransactionsData] = []
    var totalItems: Int = 0
    var currentPage: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        uploadData(page: currentPage)
    }
    
    func setupNavigation() {
        title = "To'lovlar tarixi"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "primary900")
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PaymentTVC", bundle: nil), forCellReuseIdentifier: "PaymentTVC")
    }
    
    func uploadData(page: Int) {
        Loader.start()
        let getTransactions = UserService()
        getTransactions.getTransactions(model: GetTransactionsRequest(page: page)) { result in
            switch result {
            case.success(let content):
                Loader.stop()
                guard let data = content.data else {return}
                self.dates.append(contentsOf: data)
                self.totalItems = content.meta?.total ?? 0
                self.tableView.reloadData()
            case.failure(let error):
                Loader.stop()
                Alert.showAlert(forState: .error, message: error.localizedDescription, vibrationType: .error)
            }
        }
    }
}

extension PaymentHistoryVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentTVC", for: indexPath) as? PaymentTVC else {return UITableViewCell()}
        cell.updateCell(data: self.dates[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == dates.count - 1 {
            if self.totalItems > dates.count {
                self.currentPage += 1
                self.uploadData(page: currentPage)
                self.tableView.reloadData()
            }
        }
    }
}


