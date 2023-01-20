
//  ArrivedPostVC.swift
//  Express Courier
//  Created by apple on 07/01/23.


import UIKit
import SDWebImage

class ArrivedPostVC: UIViewController {

    @IBOutlet weak var matterLbl: UILabel!
    @IBOutlet weak var arrivingPriceLbl: UILabel!
    @IBOutlet weak var insurancePriceLbl: UILabel!
    
    @IBOutlet weak var fromRegionLbl: UILabel!
    @IBOutlet weak var fromAddressLbl: UILabel!
    @IBOutlet weak var creatorNameLbl: UILabel!
    @IBOutlet weak var creatorPhoneLbl: UILabel!
    
    @IBOutlet weak var toRegionLbl: UILabel!
    @IBOutlet weak var toAddressLbl: UILabel!
    @IBOutlet weak var recipientNameLbl: UILabel!
    @IBOutlet weak var recipientPhoneLbl: UILabel!
    
    @IBOutlet weak var commentNameLbl: UILabel!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var commentImg: UIImageView!
    
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var deliveryPriceLbl: UILabel!
    @IBOutlet weak var insurPriceLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(ArrivedItemTVC.nib(), forCellReuseIdentifier: ArrivedItemTVC.identifier)
            tableView.separatorStyle = .none
        }
    }
    var id = 0

    var menuItems: [UIAction] {
        return [
            UIAction(title: "Xabarlar", image: UIImage(named: "notification-bing-post"), handler: { [self] (_) in
                let vc = ChatVC()
                vc.id = id
                self.navigationController?.pushViewController(vc, animated: true)
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
    
    var getOne: GetOneRespnseData!
    var phoneNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        getAPIResponse(id: id)
    }

    func setNavigation(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "primary900")
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        title = "#\(id)"
        if #available(iOS 14.0, *) {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", image: UIImage(named: "more-list"), primaryAction: nil, menu: demoMenu)
        } else {
            // Fallback on earlier versions
        }
    }
    
    func getAPIResponse(id: Int){
        let service = PostService()
        Loader.start()
        service.getOnePostResponse(model: PostIdRequest(id: id)) { [self] result in
            switch result{
            case.success(let content):
                guard let data = content.data else {return}
                Loader.stop()
                getOne = data
                
                arrivingPriceLbl.text = "\(getOne.delivery_fee_amount ?? 0) so'm"
                insurancePriceLbl.text = "\(getOne.insurance_amount ?? 0) so'm"
                
                fromRegionLbl.text = "\(getOne.from_region_name ?? ""), \(getOne.from_district_name ?? "")"
                fromAddressLbl.text = "\(getOne.from_address ?? "")"
                creatorNameLbl.text = "\(getOne.creator_name ?? "")"
                creatorPhoneLbl.text = "+998"
                
                toRegionLbl.text = "\(getOne.to_region_name ?? ""), \(getOne.to_district_name ?? "")"
                toAddressLbl.text = getOne.to_address ?? "+998"
                recipientPhoneLbl.text = getOne.recipient_phone ?? ""
                priceLbl.text = "\(getOne.cash_amount ?? 0) so'm"
                deliveryPriceLbl.text = "\(getOne.delivery_fee_amount ?? 0) so'm"
                insurPriceLbl.text = "\(getOne.insurance_amount ?? 0) so'm"
                         
                phoneNumber = getOne.recipient_phone ?? ""
                commentLbl.text = getOne.note ?? ""
                commentImg.sd_setImage(with: URL(string: getOne.creator_avatar ?? ""), placeholderImage: UIImage(named: "Onboarding"))
                commentNameLbl.text = getOne.creator_name ?? "Onboarding"
                matterLbl.text = getOne.matter ?? ""
                if let date = getOne.expired_at{
                    dateLbl.text = "\(String(date.prefix(10)))"
                }else{
                    dateLbl.text = "-"
                }
                
            case.failure(let error):
                Alert.showAlert(forState: .error, message: error.message ?? "Errror", vibrationType: .error)
            }
        }
    }
    
    
    @IBAction func xBtnPressed(_ sender: Any) {
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
    }
    
    @IBAction func confirmedBtnPressed(_ sender: Any) {
    }
    
    @IBAction func callBtnPressed(_ sender: Any) {
        let number = phoneNumber
        guard let number = URL(string: "tel://" + number) else { return }
        UIApplication.shared.open(number)
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
