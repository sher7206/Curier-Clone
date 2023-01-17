
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
    var selectIndexCVC: Int = 0

    var texts = ["Chirchiq", "Olmaliq", "Yunusobod","Quva", "Oltiariq","Davom"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Taqsimlash"
       // self.view.backgroundColor = UIColor(named: "white300")
    }
    
}
//MARK: TABLE VIEW
extension DistributionVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DisttributionTVC.identifier, for: indexPath) as! DisttributionTVC
        return cell
    }
}

//MARK: COLLECTION VIEW
extension DistributionVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return texts.count
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
        cell.itemLbl.text = texts[indexPath.row]
        cell.itemLbl.cornerRadius = 12
        cell.itemLbl.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.texts[indexPath.row].widthOfStringg(usingFont: .systemFont(ofSize: 15)) + 30, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            self.selectIndexCVC = indexPath.row
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        self.collectionView.reloadData()
    }
    
    
}
