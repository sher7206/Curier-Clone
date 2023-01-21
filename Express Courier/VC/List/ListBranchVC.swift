
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        uploadData(page: currentPage)
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
        
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ListVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
