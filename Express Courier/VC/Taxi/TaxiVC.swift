//
//  TaxiVC.swift
//  Express Courier
//
//  Created by Sherzod on 11/01/23.
//

import UIKit

class TaxiVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var selectIndexCVC: Int = 0
    var isNew: Bool = true
    
    var headerTexts = ["Yangilar", "Ko'rilganlar"]
    var refreshControl = UIRefreshControl()
    var newsTaxiDates: [GetNewsTaxiData]? = []
    var historyTaxiDates: [GetNewsTaxiData]? = []
    var newsCurrentPage: Int = 1
    var historyCurrentPage: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        uploadNewsTaxi(page: newsCurrentPage)
        uploadHistoryTaxi(page: historyCurrentPage)
    }
    
    func uploadNewsTaxi(page: Int) {
        Loader.start()
        let getNewTaxi = TaxiService()
        getNewTaxi.getNewsTaxi(model: TaxiRequest(page: page)) { result in
            switch result {
            case.success(let content):
                Loader.stop()
                self.newsTaxiDates?.removeAll()
                guard let data = content.data else {return}
                self.newsTaxiDates?.append(contentsOf: data)
                self.tableView.reloadData()
            case.failure(let error):
                Loader.stop()
                Alert.showAlert(forState: .error, message: error.localizedDescription, vibrationType: .error)
            }
        }
    }
    
    func uploadHistoryTaxi(page: Int) {
        Loader.start()
        let getHistoryTaxi = TaxiService()
        getHistoryTaxi.getHistoryTaxi(model: TaxiRequest(page: page)) { result in
            switch result {
            case.success(let content):
                Loader.stop()
                self.historyTaxiDates?.removeAll()
                guard let data = content.data else {return}
                self.historyTaxiDates?.append(contentsOf: data)
                self.tableView.reloadData()
            case.failure(let error):
                Loader.stop()
                print(error.localizedDescription)
                Alert.showAlert(forState: .error, message: error.localizedDescription, vibrationType: .error)
            }
        }
    }
    
    @objc func refresh(send: UIRefreshControl) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    func setupNavigation() {
        title = "Taksi"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "primary900")
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.backButtonTitle = ""
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TaxiFilterTVC", bundle: nil), forCellReuseIdentifier: "TaxiFilterTVC")
        tableView.register(UINib(nibName: "TaxiTVC", bundle: nil), forCellReuseIdentifier: "TaxiTVC")
        if #available(iOS 15.0, *) { tableView.sectionHeaderTopPadding = 0 } else {}
    }
}


//MARK: - Table View Delegate
extension TaxiVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            if isNew {
                return newsTaxiDates?.count ?? 0
            } else {
                return historyTaxiDates?.count ?? 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaxiFilterTVC", for: indexPath) as? TaxiFilterTVC else {return UITableViewCell()}
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaxiTVC", for: indexPath) as? TaxiTVC else {return UITableViewCell()}
            if isNew {
                cell.updateCell(data: self.newsTaxiDates?[indexPath.row], index: indexPath.row)
            } else {
                cell.updateCell(data: self.historyTaxiDates?[indexPath.row], index: indexPath.row)
            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 45))
        v.backgroundColor = UIColor(named: "primary900")
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width / 2, height: 45)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        self.view.addSubview(collectionView)
        collectionView.delegate   = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "TaxiHeaderCVC", bundle: nil), forCellWithReuseIdentifier: "TaxiHeaderCVC")
        v.addSubview(collectionView)
        collectionView.backgroundColor = UIColor(named: "primary900")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: v.topAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: 0).isActive = true
        layout.collectionView?.showsHorizontalScrollIndicator = false
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section != 0 {
            return 45
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isNew {
            let vc = TaxiNewsModalVC()
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        } else {
            let vc = TaxiOldUserModalVC()
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
}

//MARK: - Collection View Delegate
extension TaxiVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TaxiHeaderCVC", for: indexPath) as? TaxiHeaderCVC else {return UICollectionViewCell()}
        
        cell.bottomView.backgroundColor = .clear
        cell.titleLbl.textColor = UIColor(named: "black600")
        cell.titleLbl.font = .systemFont(ofSize: 14, weight: .regular)
        if selectIndexCVC == indexPath.row {
            cell.bottomView.backgroundColor = .black
            cell.titleLbl.textColor = .black
            cell.titleLbl.font = .systemFont(ofSize: 15, weight: .medium)
        } else {
            cell.bottomView.backgroundColor = .clear
            cell.titleLbl.textColor = UIColor(named: "black600")
            cell.titleLbl.font = .systemFont(ofSize: 15, weight: .regular)
        }
        cell.updateCell(title: headerTexts[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectIndexCVC = indexPath.row
        if indexPath.row == 0 {
            self.historyTaxiDates?.removeAll()
            self.isNew = true
            uploadNewsTaxi(page: newsCurrentPage)
        } else {
            self.newsTaxiDates?.removeAll()
            self.isNew = false
            uploadHistoryTaxi(page: historyCurrentPage)
        }
        collectionView.reloadData()
    }
}
