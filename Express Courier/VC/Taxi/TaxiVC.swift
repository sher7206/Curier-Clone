//
//  TaxiVC.swift
//  Express Courier
//
//  Created by Sherzod on 11/01/23.
//

import UIKit
import LocalAuthentication

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
    var newsDataTotal: Int = 0
    var historyDataTotal: Int = 0
    
    var fromRegionText: String = "Viloyat, tuman"
    var toRegionText: String = "Viloyat, tuman"
    
    var fromRegionId: Int?
    var fromDistrictId: Int?
    var toRegionId: Int?
    var toDistrictId: Int?
    
    var isLeftRegion: Bool = true
    var selectIndexTVC: Int = 0
    var isReplacement: Bool = true
    
    var lastContentOffset: CGFloat = 0
    var downScroll: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        self.newsAllDates()
        self.historyAllDates()
        setUpScretchView()
    }
    
   
    
    func uploadNewsTaxi(page: Int, fromReg: Int?, fromDis: Int?, toReg: Int?, toDis: Int?) {
        Loader.start()
        let getNewTaxi = TaxiService()
        getNewTaxi.getNewsTaxi(model: TaxiRequest(page: page, fromRegionId: fromReg, fromDistrictId: fromDis, toRegionId: toReg, toDistrictId: toDis)) { result in
            switch result {
            case.success(let content):
                Loader.stop()
                guard let data = content.data else {return}
                self.newsDataTotal = content.meta?.total ?? 0
                self.newsTaxiDates?.append(contentsOf: data)
                self.tableView.reloadData()
            case.failure(let error):
                Loader.stop()
                Alert.showAlert(forState: .error, message: error.localizedDescription, vibrationType: .error)
            }
        }
    }
    
    func uploadHistoryTaxi(page: Int, fromReg: Int?, fromDis: Int?, toReg: Int?, toDis: Int?) {
        Loader.start()
        let getHistoryTaxi = TaxiService()
        getHistoryTaxi.getHistoryTaxi(model: TaxiRequest(page: page, fromRegionId: fromReg, fromDistrictId: fromDis, toRegionId: toReg, toDistrictId: toDis)) { result in
            switch result {
            case.success(let content):
                Loader.stop()
                guard let data = content.data else {return}
                self.historyDataTotal = content.meta?.total ?? 0
                self.historyTaxiDates?.append(contentsOf: data)
                self.tableView.reloadData()
            case.failure(let error):
                Loader.stop()
                print(error.localizedDescription)
                Alert.showAlert(forState: .error, message: error.localizedDescription, vibrationType: .error)
            }
        }
    }
    
    func setUpScretchView(){
        let header = SkretchableHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 5))
        header.v.backgroundColor = UIColor(named: "primary900")
        tableView.tableHeaderView = header
        self.view.backgroundColor = UIColor(named: "white300")
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
extension TaxiVC: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if downScroll {
                return UITableView.automaticDimension
            } else {
                return 0
            }
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaxiFilterTVC", for: indexPath) as? TaxiFilterTVC else {return UITableViewCell()}
            cell.delegate = self
            cell.updateCell(from: fromRegionText, to: toRegionText, fromRegionId: self.fromRegionId, toRegionId: self.toRegionId)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaxiTVC", for: indexPath) as? TaxiTVC else {return UITableViewCell()}
            if isNew {
                hideShowDate(index: indexPath.row, dates: self.newsTaxiDates, dateLabel: cell.dateLbl)
                cell.updateCell(data: self.newsTaxiDates?[indexPath.row], index: indexPath.row)
            } else {
                hideShowDate(index: indexPath.row, dates: self.historyTaxiDates, dateLabel: cell.dateLbl)
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
            self.selectIndexTVC = indexPath.row
            let vc = TaxiNewsModalVC()
            vc.delegate = self
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        } else {
            let vc = TaxiOldUserModalVC()
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = tableView.tableHeaderView as? SkretchableHeaderView else{return}
        header.crollViewDidScroll(scrollView: tableView)
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        if translation.y > 0 {
            if !downScroll {
                self.tableView.beginUpdates()
                self.downScroll = true
                self.tableView.endUpdates()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isNew {
            guard let data = newsTaxiDates else {return}
            if indexPath.row == data.count - 1 {
                if self.newsDataTotal > data.count {
                    self.newsCurrentPage += 1
                    Loader.start()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        Loader.stop()
                        self.uploadNewsTaxi(page: self.newsCurrentPage, fromReg: self.fromRegionId, fromDis: self.fromDistrictId, toReg: self.toRegionId, toDis: self.toDistrictId)
                    }
                }
            }
        } else {
            guard let data = historyTaxiDates else {return}
            if indexPath.row == data.count - 1 {
                if self.historyDataTotal > data.count {
                    self.historyCurrentPage += 1
                    Loader.start()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        Loader.stop()
                        self.uploadHistoryTaxi(page: self.newsCurrentPage, fromReg: self.fromRegionId, fromDis: self.fromDistrictId, toReg: self.toRegionId, toDis: self.toDistrictId)
                    }
                }
            }
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
            self.isNew = true
            self.newsAllDates()
        } else {
            self.isNew = false
            self.historyAllDates()
        }
        self.tableView.reloadData()
        collectionView.reloadData()
    }
}

//MARK: - TaxiFilterTVCDelegate
extension TaxiVC: TaxiFilterTVCDelegate {
    func fromRegionTapped() {
        self.isLeftRegion = true
        let vc = RegionsVC()
        vc.vc = self
        present(vc, animated: true)
    }
    
    func toRegionTapped() {
        self.isLeftRegion = false
        let vc = RegionsVC()
        vc.vc = self
        present(vc, animated: true)
    }
    
    func fromCloseTapped() {
        
        if fromRegionId == nil || toDistrictId == nil {
            self.toRegionId = nil
            self.toDistrictId = nil
        }
        
        self.fromRegionId = nil
        self.fromDistrictId = nil
        self.fromRegionText = "Viloyat, tuman"
        if isNew {
            self.newsAllDates()
        } else {
            self.historyAllDates()
        }
        
    }
    
    func toCloseTapped() {
        
        if toRegionId == nil || toDistrictId == nil {
            self.fromRegionId = nil
            self.fromDistrictId = nil
        }
        
        self.toRegionId = nil
        self.toDistrictId = nil
        self.toRegionText = "Viloyat, tuman"
        if isNew {
            self.newsAllDates()
        } else {
            self.historyAllDates()
        }
    }
    
    func replaceTapped() {
        
        let a = fromRegionText
        let b = toRegionText
        self.fromRegionText = b
        self.toRegionText = a
        
        if isNew {
            self.newsCurrentPage = 1
            if isReplacement {
                self.uploadNewsTaxi(page: newsCurrentPage, fromReg: toRegionId, fromDis: toDistrictId, toReg: fromRegionId, toDis: fromDistrictId)
            } else {
                self.uploadNewsTaxi(page: newsCurrentPage, fromReg: fromRegionId, fromDis: fromDistrictId, toReg: toRegionId, toDis: toDistrictId)
            }
        } else {
            self.historyCurrentPage = 1
            if isReplacement {
                self.uploadHistoryTaxi(page: self.historyCurrentPage, fromReg: fromRegionId, fromDis: fromDistrictId, toReg: toRegionId, toDis: toDistrictId)
            } else {
                self.uploadHistoryTaxi(page: self.historyCurrentPage, fromReg: toRegionId, fromDis: toDistrictId, toReg: fromRegionId, toDis: fromDistrictId)
            }
        }
        self.isReplacement = !self.isReplacement
    }
}

//MARK: - Region Selected Delegate
extension TaxiVC: RegionSelectedVCDelegate {
    func setLocatoin(region id: Int, regoin name: String, state: States, isToRegion: Bool) {
        if isNew {
            if isLeftRegion {
                self.fromRegionText = name + ", " + state.name
                self.fromRegionId = id
                self.fromDistrictId = state.id
                self.newsAllDates()
            } else {
                self.toRegionText = name + ", " + state.name
                self.toRegionId = id
                self.toDistrictId = state.id
                self.newsAllDates()
            }
        } else {
            if isLeftRegion {
                self.fromRegionText = name + ", " + state.name
                self.fromRegionId = id
                self.fromDistrictId = state.id
                self.historyAllDates()
            } else {
                self.toRegionText = name + ", " + state.name
                self.toRegionId = id
                self.toDistrictId = state.id
                self.historyAllDates()
            }
        }
    }
}

//MARK: - Call Tapped
extension TaxiVC: TaxiNewsModalVCDelegate {
    func callTapped() {
        let posTaxi = TaxiService()
        posTaxi.taxiPost(model: TaxiPostRequest(id: self.newsTaxiDates?[selectIndexTVC].id ?? 0)) { result in
            switch result {
            case.success(let content):
                print(content)
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension TaxiVC {
    func newsAllDates() {
        self.newsCurrentPage = 1
        self.historyTaxiDates?.removeAll()
        self.newsTaxiDates?.removeAll()
        self.uploadNewsTaxi(page: newsCurrentPage, fromReg: fromRegionId, fromDis: fromDistrictId, toReg: toRegionId, toDis: toDistrictId)
    }
    
    func historyAllDates() {
        self.historyCurrentPage = 1
        self.newsTaxiDates?.removeAll()
        self.historyTaxiDates?.removeAll()
        self.uploadHistoryTaxi(page: historyCurrentPage, fromReg: fromRegionId, fromDis: fromDistrictId, toReg: toRegionId, toDis: toDistrictId)
    }
}

extension TaxiVC {
    func hideShowDate(index: Int, dates: [GetNewsTaxiData]?, dateLabel: UILabel) {
        if index == 0 {
            dateLabel.isHidden = false
        } else {
            let first = dates?[index - 1].created_at ?? ""
            let second = dates?[index].created_at ?? ""
            if first.prefix(10) == second.prefix(10) {
                dateLabel.isHidden  = true
            } else {
                dateLabel.isHidden  = false
            }
        }
    }
}
