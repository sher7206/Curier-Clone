
//  DistributionVC.swift
//  Express Courier
//  Created by apple on 17/01/23.

import UIKit

class DistributionVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(ItemCVC.nib(), forCellWithReuseIdentifier: ItemCVC.identifier)
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 11, bottom: 0, right: 0)
        }
    }
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(DisttributionTVC.nib(), forCellReuseIdentifier: DisttributionTVC.identifier)
            tableView.separatorStyle = .none
        }
    }
    @IBOutlet weak var emptyView: UIView!
    
    
    var itemId: Int = 0
    var selectIndexCVC: Int = 0
    var districtDtaes: [ListDistrictData] = []
    var currentPage: Int = 1
    var dates: [ListPackagesData] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "list_toolbar3".localized
        uploadDistrict()
    }
    
    func uploadDistrict() {
        Loader.start()
        let getDistrict = ListService()
        getDistrict.listDistrict(model: ListDistrictResquest(id: self.itemId)) { result in
            switch result {
            case.success(let content):
                Loader.stop()
                guard let data = content.data else {return}
                self.districtDtaes.append(contentsOf: data)
                self.emptyView(view: self.emptyView, count: self.districtDtaes.count, tableView: self.tableView)
                self.uploadData(page: self.currentPage, id: self.districtDtaes[0].id ?? 0)
                self.collectionView.reloadData()
            case.failure(let error):
                Loader.stop()
                Alert.showAlert(forState: .error, message: error.localizedDescription, vibrationType: .error)
            }
        }
    }
    
    func uploadData(page: Int, id: Int) {
        Loader.start()
        let getDates = ListService()
        getDates.listDistrictDates(model: ListDistrictDatesRequest(id: self.itemId, page: page, status: "active", toDistrictId: id)) { result in
            switch result {
            case.success(let content):
                Loader.stop()
                guard let data = content.data else {return}
                self.dates.append(contentsOf: data)
                self.currentPage = content.meta?.total ?? 0
                self.emptyView(view: self.emptyView, count: self.dates.count, tableView: self.tableView)
                self.tableView.reloadData()
            case.failure(let error):
                Loader.stop()
                Alert.showAlert(forState: .error, message: error.localizedDescription, vibrationType: .error)
            }
        }
    }
    
}
//MARK: TABLE VIEW
extension DistributionVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dates.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DisttributionTVC.identifier, for: indexPath) as! DisttributionTVC
        
        if indexPath.row == 0 {
            cell.dateLbl.isHidden = false
        }else{
            let first = dates[indexPath.row-1].created_at
            let second = dates[indexPath.row].created_at
            if first?.prefix(10) == second?.prefix(10){
                cell.dateLbl.isHidden = true
            }else{
                cell.dateLbl.isHidden = false
            }
        }
        
        
        cell.updateCell(data: self.dates[indexPath.row])
        return cell
    }
}

//MARK: COLLECTION VIEW
extension DistributionVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return districtDtaes.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCVC.identifier, for: indexPath) as! ItemCVC
        if selectIndexCVC == indexPath.row {
            cell.itemLbl.textColor = .black
            cell.itemLbl.font = .systemFont(ofSize: 15, weight: .medium)
            cell.itemLbl.backgroundColor = UIColor(named: "primary900")
        } else {
            cell.itemLbl.textColor = UIColor(named: "black600")
            cell.itemLbl.font = .systemFont(ofSize: 15, weight: .regular)
            cell.itemLbl.backgroundColor = UIColor(named: "white100")
        }
        cell.updateCell(data: self.districtDtaes[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.districtDtaes[indexPath.row].name?.widthOfStringg(usingFont: .systemFont(ofSize: 15)) ?? 0) + 30, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            self.selectIndexCVC = indexPath.row
        self.currentPage = 1
        self.dates.removeAll()
        self.emptyView.isHidden = true
        self.tableView.reloadData()
        self.uploadData(page: self.currentPage, id: self.districtDtaes[indexPath.row].id ?? 0)
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        self.collectionView.reloadData()
    }
}
