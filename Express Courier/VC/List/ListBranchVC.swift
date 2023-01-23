
//  ListBranchVC.swift
//  Express Courier
//  Created by apple on 14/01/23.

import UIKit

class ListBranchVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(BranchListTVC.nib(), forCellReuseIdentifier: BranchListTVC.identifier)
            tableView.separatorStyle = .none
            tableView.contentInset = UIEdgeInsets(top: 11, left: 0, bottom: 11, right: 0)
        }
    }
    
    var dates: [GetAllPackagesData] = []
    var currentPage: Int = 1
    var totalItems: Int = 0
    var refreshControl = UIRefreshControl()
    
    
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
        title = "Ro'yhatlar"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "primary900")
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.backButtonTitle = ""
    }
    
    func uploadData(page: Int) {
        Loader.start()
        let getAllPackages = ListService()
        getAllPackages.getAllPackages(model: getAllPackagesRequest(page: page)) { result in
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

//MARK: TABLE VIEW
extension ListBranchVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dates.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BranchListTVC.identifier, for: indexPath) as? BranchListTVC else {return UITableViewCell()}
        cell.updateCell(data: self.dates[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ListVC()
        let data = self.dates[indexPath.row]
        vc.itemId = data.id ?? 0
        vc.itemTitle = (data.storage_name ?? "") + " - " + "#\(data.id ?? 0)"
        vc.packages_count = data.packages_count ?? 0
        vc.packages_count_sold = data.packages_count_sold  ?? 0
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.dates.count - 1 {
            if self.totalItems > self.dates.count {
                self.currentPage += 1
                self.uploadData(page: currentPage)
            }
        }
    }
}
