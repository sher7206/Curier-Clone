
//  RegionsVC.swift
//  100kExpress
//  Created by Sherzod on 28/11/22.

import UIKit


protocol RegionSelectedVCDelegate {
    func setLocatoin(region id: Int, regoin name: String, state: States, isToRegion: Bool)
}

protocol BranchSelectedDelegate{
    func branchId(branch id: Int, branch name: String)
    func setLocatoinRegion(region id: Int, regoin name: String, stateId: Int, stateName: String)
}

enum RegionSelectedPageType {
    case region
    case states
}

struct RegionDM {
    let id: Int
    var name: String
    var states: [States]
}

struct States {
    let id: Int
    var name: String
    var region_id: Int
}

class RegionsVC: UIViewController {
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "RegionTVC", bundle: nil), forCellReuseIdentifier: "RegionTVC")
        }
    }
    
    @IBOutlet var headerView: UIView!
    
    var currentPage: Int = 1
    
    var totalItems: Int = 0
    
    var pageType: RegionSelectedPageType = .region
    var regions: [RegionDM] = []
    var region: RegionDM!
    var vc: UIViewController!
    var delegate: RegionSelectedVCDelegate?
    var branchDelegate: BranchSelectedDelegate?
    
    var isStore = false
    var isToRegion = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch pageType {
        case .region:
            uploadRegion()
            print("Nurillo")
        case .states: break
        }
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }
    
    func uploadRegion() {
        let getRegion = UserService()
        getRegion.getRegion { result in
            switch result {
            case.success(let content):
                guard let data = content.data else {return}
                for i in data {
                    var region = RegionDM(id: i.id ?? 0, name: i.name ?? "", states: [])
                    guard let dis = i.districts else {return}
                    for j in dis {
                        region.states.append(States(id: j.id ?? 0, name: j.name ?? "", region_id: j.region_id ?? 0))
                    }
                    self.regions.append(region)
                }
                self.tableView.reloadData()
            case.failure(let error):
                print(error.localizedDescription)
                Alert.showAlert(forState: .error, message: error.localizedDescription, vibrationType: .error)
            }
        }
    }
    
    //    func getStore(page: Int){
    //        let getStore = ExpressService()
    //        getStore.getStores(model: GetStoreRequest(page: page)) { result in
    //            switch result{
    //            case.success(let content):
    //                self.totalItems = content.meta?.to ?? 0
    //                guard let datas = content.data else{return}
    //                self.getAllDates?.append(contentsOf: datas)
    //                self.tableView.reloadData()
    //            case.failure(let error):
    //                Alert.showAlert(forState: .error, message: error.localizedDescription, vibrationType: .error)
    //            }
    //        }
    //    }
    
    @objc func closeTapped() {
        self.dismiss(animated: true)
    }
    
}

extension RegionsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pageType == .region ? regions.count  : region.states.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RegionTVC", for: indexPath) as? RegionTVC else {return UITableViewCell()}
        cell.updateCell(textlbl: pageType == .region ? regions[indexPath.row].name  : region.states[indexPath.row].name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 50))
        v.backgroundColor = .white
        v.layer.shadowColor = UIColor.systemGray3.cgColor
        v.layer.shadowOpacity = 0.3
        v.layer.shadowOffset = CGSize(width: 0, height: 1)
        v.layer.shadowRadius = 1
        
        let btn: UIButton = {
            let btn = UIButton()
            btn.backgroundColor = .clear
            btn.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
            return btn
        }()
        
        let img = UIImageView()
        img.image = UIImage(systemName: "arrow.left")
        img.tintColor = .black
        
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 16)
        
        if isStore {
            lbl.text = "Filialni tanlang"
        } else {
            switch pageType {
            case.region:
                lbl.text = "Viloyatni tanlang"
            case.states:
                lbl.text = "Tumanni tanlang"
            }
            
        }
        
        let stack: UIStackView = {
            let stack = UIStackView()
            stack.alignment = .center
            stack.distribution = .fill
            stack.spacing = 20
            return stack
        }()
        
        v.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 16).isActive = true
        stack.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: -16).isActive = true
        stack.topAnchor.constraint(equalTo: v.topAnchor, constant: 10).isActive = true
        stack.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: -10).isActive = true
        
        stack.addArrangedSubview(img)
        img.translatesAutoresizingMaskIntoConstraints = false
        img.heightAnchor.constraint(equalToConstant: 20).isActive = true
        img.widthAnchor.constraint(equalToConstant: 20).isActive = true
        stack.addArrangedSubview(lbl)
        v.addSubview(btn)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.topAnchor.constraint(equalTo: v.topAnchor, constant: 0).isActive = true
        btn.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 0).isActive = true
        btn.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: 0).isActive = true
        btn.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: 0).isActive = true
        
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch pageType {
        case .region:
            let vc = RegionsVC()
            vc.pageType = .states
            vc.region = regions[indexPath.row]
            vc.isToRegion = self.isToRegion
            vc.delegate = self.vc as? RegionSelectedVCDelegate
            self.present(vc, animated: true)
        case .states:
            
            self.delegate?.setLocatoin(region: region.id, regoin: region.name, state: region.states[indexPath.row], isToRegion: isToRegion)
            
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
}
