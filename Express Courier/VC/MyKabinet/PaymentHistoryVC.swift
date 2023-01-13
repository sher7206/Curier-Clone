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
    
    var currentPage: Int = 0
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
        let getTransactions = UserService()
        getTransactions.getTransactions(model: GetTransactionsRequest(page: page)) { result in
            switch result {
            case.success(let content):
                guard let data = content.data else {return}
                self.dates.append(contentsOf: data)
                self.tableView.reloadData()
            case.failure(let error):
                print(error.localizedDescription)
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
        
        return cell
    }
}


