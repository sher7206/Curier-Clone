
//  FinishOrderVC.swift
//  Express Courier
//  Created by apple on 12/01/23.


import UIKit

class FinishOrderVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(ArrivedItemTVC.nib(), forCellReuseIdentifier: ArrivedItemTVC.identifier)
            tableView.separatorStyle = .none
        }
    }
    @IBOutlet weak var contView: UIView!
    @IBOutlet weak var headerView: UIView!{
        didSet{
            headerView.layer.shadowColor = UIColor(named: "black500")?.cgColor
            headerView.layer.shadowOpacity = 0.2
            headerView.layer.shadowOffset = CGSize(width: 0, height: 2)
            headerView.layer.shadowRadius = 1
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openAnimetion()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contView.roundCorners(corners: [.topLeft, .topRight], radius: 25)
        contView.clipsToBounds = true
    }
    
    func openAnimetion() {
        Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { _ in
            UIView.animate(withDuration: 0.4) {
                self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            }
        }
    }

    func dismissFunc() {
        self.view.backgroundColor = .clear
        self.dismiss(animated: true)
    }

    @IBAction func dismissBtnPressed(_ sender: Any) {
        dismissFunc()
    }
    
    
}

//MARK: Table View
extension FinishOrderVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArrivedItemTVC.identifier, for: indexPath) as! ArrivedItemTVC
        cell.selectionStyle = .none
        return cell
    }
}
