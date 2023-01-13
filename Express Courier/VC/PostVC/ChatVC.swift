
//  ChatVC.swift
//  Express Courier
//  Created by apple on 11/01/23.

import UIKit

class ChatVC: UIViewController {

    @IBOutlet weak var chatTF: UITextField!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(ChatTVC.nib(), forCellReuseIdentifier: ChatTVC.identifier)
            tableView.separatorStyle = .none
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
    }
    
    func setUpNavigation(){
        title = "Xabarlar"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "primary900")
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    
    @IBAction func sendBtnPressed(_ sender: Any) {
    }
    
    
}

//MARK: Table View
extension ChatVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatTVC.identifier, for: indexPath) as! ChatTVC
        return cell
    }
}
