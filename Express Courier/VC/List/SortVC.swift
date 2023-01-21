//
//  SortVC.swift
//  Express Courier
//
//  Created by apple on 16/01/23.
//

import UIKit

class SortVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(SortTVC.nib(), forCellReuseIdentifier: SortTVC.identifier)
            tableView.separatorStyle = .none
            tableView.contentInset = UIEdgeInsets(top: 11, left: 0, bottom: 11, right: 0)
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(ItemCVC.nib(), forCellWithReuseIdentifier: ItemCVC.identifier)
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 11, bottom: 0, right: 0)
        }
    }
    
    
    @IBOutlet weak var segmentControlOutlet: UISegmentedControl!
    
    var selectIndexCVC: Int = 0
    var headerTexts = ["Barchasi", "Yo‘lda", "Yetkazilgan", "Bekor qilingan"]
    
    var itemId: Int = 0
    var groupBy: String = "matter"
    var status: String?
    var dates: [CountPackagesData] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Saralash"
        uploadData(status: status, groupBy: groupBy)
    }
    
    func uploadData(status: String?, groupBy: String) {
        Loader.start()
        let countPackages = ListService()
        countPackages.countPackages(model: CountPackagesRequest(id: self.itemId, status: status, group_by: groupBy)) { result in
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
    
    @IBAction func segmentControllClick(_ sender: UISegmentedControl) {
        switch segmentControlOutlet.selectedSegmentIndex {
        case 0:
            self.dates.removeAll()
            self.tableView.reloadData()
            self.groupBy = "matter"
            self.uploadData(status: status, groupBy: self.groupBy)
        default:
            self.dates.removeAll()
            self.tableView.reloadData()
            self.groupBy = "to_district_id"
            self.uploadData(status: status, groupBy: self.groupBy)
        }
    }
}

//MARK: TABLE VIEW
extension SortVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dates.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SortTVC.identifier, for: indexPath) as! SortTVC
        cell.updateCell(data: self.dates[indexPath.row])
        return cell
    }
    
}

//MARK: COLLECTION VIEW
extension SortVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return headerTexts.count
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
        cell.itemLbl.text = headerTexts[indexPath.row]
        cell.itemLbl.cornerRadius = 12
        cell.itemLbl.clipsToBounds = true
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.headerTexts[indexPath.row].widthOfStringg(usingFont: .systemFont(ofSize: 15)) + 30, height: 40)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectIndexCVC = indexPath.row
        if indexPath.row == 0 {
            self.status = nil
            self.dates.removeAll()
            self.tableView.reloadData()
            self.uploadData(status: status, groupBy: groupBy)
            
        } else if indexPath.row == 1 {
            self.status = "active"
            self.dates.removeAll()
            self.tableView.reloadData()
            self.uploadData(status: status, groupBy: groupBy)
        } else if indexPath.row == 2 {
            self.status = "completed"
            self.dates.removeAll()
            self.tableView.reloadData()
            self.uploadData(status: status, groupBy: groupBy)
        } else {
            self.status = "canceled"
            self.dates.removeAll()
            self.tableView.reloadData()
            self.uploadData(status: status, groupBy: groupBy)
        }
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        collectionView.reloadData()
    }
}

