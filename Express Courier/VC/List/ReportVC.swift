//
//  ReportVC.swift
//  Express Courier
//
//  Created by apple on 16/01/23.
//

import UIKit

class ReportVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(ReportTVC.nib(), forCellReuseIdentifier: ReportTVC.identifier)
            tableView.separatorStyle = .none
            tableView.contentInset = UIEdgeInsets(top: 11, left: 0, bottom: 11, right: 0)
        }
    }
    
    var itemId: Int = 0
    var dates: [StatsPackagesData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Statistika"
        uploadData()
        
    }
    
    func uploadData() {
        Loader.start()
        let getStats = ListService()
        getStats.statsPackages(model: StatsPackagesRequest(id: self.itemId)) { result in
            switch result {
            case.success(let content):
                Loader.stop()
                guard let data = content.data else {return}
                self.dates.append(contentsOf: data)
                self.tableView.reloadData()
            case.failure(let error):
                Loader.stop()
                Alert.showAlert(forState: .error, message: error.localizedDescription, vibrationType: .error)
            }
        }
    }

}

//MARK: TABLE VIEW
extension ReportVC: UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReportTVC.identifier, for: indexPath) as? ReportTVC else {return UITableViewCell()}
        cell.updateCell(data: self.dates[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
}
