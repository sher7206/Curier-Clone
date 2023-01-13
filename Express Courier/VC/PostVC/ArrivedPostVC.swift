//  ArrivedPostVC.swift
//  Express Courier
//  Created by apple on 07/01/23.

import UIKit

class ArrivedPostVC: UIViewController {

    @IBOutlet weak var arrivingPriceLbl: UILabel!
    @IBOutlet weak var insurancePriceLbl: UILabel!
    @IBOutlet weak var fromRegionLbl: UILabel!
    @IBOutlet weak var fromAddressLbl: UILabel!
    @IBOutlet weak var toRegionLbl: UILabel!
    @IBOutlet weak var tomAddressLbl: UILabel!
    @IBOutlet weak var commentNameLbl: UILabel!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var commentImg: UIImageView!
    
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var deliveryPriceLbl: UILabel!
    @IBOutlet weak var insurPriceLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!

    var menuItems: [UIAction] {
        return [
            UIAction(title: "Xabarlar", image: UIImage(named: "notification-bing-post"), handler: { (_) in
            }),
            UIAction(title: "Taymer kiritish", image: UIImage(named: "clock-post"), handler: { (_) in
            }),
            UIAction(title: "Buyurtma olish", image: UIImage(named: "repeat-post"), handler: { (_) in
            })
        ]
    }

    var demoMenu: UIMenu {
        return UIMenu(title: "", image: UIImage(named: "more-list"), identifier: nil, options: [], children: menuItems)
    }
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(ArrivedItemTVC.nib(), forCellReuseIdentifier: ArrivedItemTVC.identifier)
            tableView.separatorStyle = .none
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
    }

    func setNavigation(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "primary900")
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        title = "#12345"
        

        if #available(iOS 14.0, *) {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", image: UIImage(named: "more-list"), primaryAction: nil, menu: demoMenu)
        } else {
            // Fallback on earlier versions
        }

    }
    
    
    
    @IBAction func xBtnPressed(_ sender: Any) {
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
    }
    
    @IBAction func confirmedBtnPressed(_ sender: Any) {
    }
    
    @IBAction func callBtnPressed(_ sender: Any) {

    }
    
    @IBAction func callCommentorBtnPressed(_ sender: Any) {
        
    }
    
}


//MARK: Table View
extension ArrivedPostVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArrivedItemTVC.identifier, for: indexPath) as! ArrivedItemTVC
        cell.selectionStyle = .none
        return cell
    }
}
