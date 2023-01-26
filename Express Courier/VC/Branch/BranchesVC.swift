//
//  BranchesVC.swift
//  Express Courier
//
//  Created by Sherzod on 19/01/23.
//

import UIKit

class BranchesVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    var dates: [BranchData] = []
    var currentPage: Int = 1
    var totalItems: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        uploadData(page: currentPage)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(send: UIRefreshControl) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "BranchesTVC", bundle: nil), forCellReuseIdentifier: "BranchesTVC")
    }
    
    func uploadData(page: Int) {
        Loader.start()
        let getBranches = BranchService()
        getBranches.getBranches(model: GetBranchRequest(page: page)) { result in
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

extension BranchesVC: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BranchesTVC", for: indexPath) as? BranchesTVC else {return UITableViewCell()}
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
