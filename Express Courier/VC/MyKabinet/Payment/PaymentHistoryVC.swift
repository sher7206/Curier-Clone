//
//  PaymentHistoryVC.swift
//  Express Courier
//
//  Created by Sherzod on 06/01/23.
//

import UIKit

class PaymentHistoryVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyLbl: UILabel!
    
    var dates: [GetTransactionsData] = []
    var totalItems: Int = 0
    var currentPage: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        uploadData(page: currentPage)
        emptyLbl.isHidden = true
    }
    
    func setupNavigation() {
        navigationItem.title = "kabinet_main1".localized
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
                self.isEmptyDates(dates: self.dates, textLbl: self.emptyLbl)
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
            }
        }
    }
}

extension PaymentHistoryVC {
    func isEmptyDates(dates: [GetTransactionsData], textLbl: UILabel) {
        if dates.count == 0 {
            textLbl.isHidden = false
        } else {
            textLbl.isHidden = true
        }
    }
}

