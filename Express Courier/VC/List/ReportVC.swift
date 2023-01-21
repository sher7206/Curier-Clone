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
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Statistika"
    }
    

}

//MARK: TABLE VIEW
extension ReportVC: UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReportTVC.identifier, for: indexPath) as! ReportTVC
        cell.selectionStyle = .none
        return cell
    }
    
}
