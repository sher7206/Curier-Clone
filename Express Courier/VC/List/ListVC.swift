
//  ListVC.swift
//  Express Courier
//  Created by Sherzod on 13/01/23.

import UIKit

class ListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterSubView: UIView!
    @IBOutlet weak var filterCollectionView: UICollectionView!
    @IBOutlet weak var emptyView: UIView!
    
    var itemId: Int = 0
    let search = UISearchController(searchResultsController: nil)
    let headerTexts = ["Yo'lda", "Yetkazilgan", "Bekor qilingan"]
    var selectIndexCVC: Int = 0
    var backColor: UIColor =  UIColor(named: "primary900")!
    var backWhiteColor: UIColor = UIColor(named: "white300")!
    var dates: [ListPackagesData] = []
    var districtDtaes: [ListDistrictData] = []
    var itemStatus: String = "active"
    var currentPage: Int = 1
    var totalItems: Int = 0
    var itemTitle: String = ""
    var packages_count: Int = 0
    var packages_count_sold: Int = 0
    var districtId: Int?
    
    
    var menuItems: [UIAction] {
        return [
            UIAction(title: "Statistika", image: UIImage(named: "diagram-list"), handler: { (_) in
                let vc = ReportVC()
                vc.itemId = self.itemId
                self.navigationController?.pushViewController(vc, animated: true)
            }),
            UIAction(title: "Hisoblash", image: UIImage(named: "math-list"), handler: { (_) in
                let vc = SortVC()
                vc.itemId = self.itemId
                self.navigationController?.pushViewController(vc, animated: true)
            }),
            UIAction(title: "Taqsimlash", image: UIImage(named: "discount-circle-list"), handler: { (_) in
                let vc = DistributionVC()
                vc.itemId = self.itemId
                self.navigationController?.pushViewController(vc, animated: true)
            }),
            UIAction(title: "Jurnal", image: UIImage(named: "note-list"), handler: { (_) in
            })
        ]
    }
    var demoMenu: UIMenu {
        return UIMenu(title: "", image: UIImage(named: "more-list"), identifier: nil, options: [], children: menuItems)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = search
        search.searchBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        self.extendedLayoutIncludesOpaqueBars = true
        setupNavigation()
        setUpScretchView()
        uploadDistrict()
        uploadData(page: self.currentPage, status: itemStatus, districtId: districtId)
    }
    
    func setUpScretchView(){
        let header = SkretchableHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 1))
        header.v.backgroundColor = UIColor(named: "primary900")
        tableView.tableHeaderView = header
        self.view.backgroundColor = UIColor(named: "white300")
    }
    
    func setupNavigation() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "primary900")
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.backButtonTitle = ""
        if #available(iOS 14.0, *) {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", image: UIImage(named: "more-list"), primaryAction: nil, menu: demoMenu) } else {}
        titleViewFunc(navigationTitle: itemTitle, title: "\(self.packages_count)/\(self.packages_count_sold)")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TaxiFilterTVC.nib(), forCellReuseIdentifier: TaxiFilterTVC.identifier)
        tableView.register(PostInsideTVC.nib(), forCellReuseIdentifier: PostInsideTVC.identifier)
        tableView.separatorStyle = .none
        if #available(iOS 15.0, *) { tableView.sectionHeaderTopPadding = 0 } else {}
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        filterCollectionView.register(UINib(nibName: "ItemCVC", bundle: nil), forCellWithReuseIdentifier: "ItemCVC")
        filterSubView.transform = .init(scaleX: 0.5, y: 0.5)
        filterSubView.alpha = 0
        
    }
    
    func titleViewFunc(navigationTitle: String, title: String) {
        
        let v = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        
        let stack: UIStackView = {
            let stack = UIStackView()
            stack.alignment = .center
            stack.distribution = .equalSpacing
            stack.axis = .vertical
            stack.spacing = 0
            return stack
        }()
        
        let lbl1: UILabel = {
            let lbl = UILabel()
            lbl.text = navigationTitle
            lbl.font = .systemFont(ofSize: 16, weight: .semibold)
            lbl.textAlignment = .center
            return lbl
        }()
        
        let lbl2: UILabel = {
            let lbl = UILabel()
            lbl.text = title
            lbl.font = .systemFont(ofSize: 13)
            lbl.textAlignment = .center
            return lbl
        }()
        
        v.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 0).isActive = true
        stack.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: 0).isActive = true
        stack.topAnchor.constraint(equalTo: v.topAnchor, constant: 0).isActive = true
        stack.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: 0).isActive = true
        stack.addArrangedSubview(lbl1)
        stack.addArrangedSubview(lbl2)
        self.navigationItem.titleView = v
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
                self.filterCollectionView.reloadData()
            case.failure(let error):
                Loader.stop()
                Alert.showAlert(forState: .error, message: error.localizedDescription, vibrationType: .error)
            }
        }
    }
    
    func uploadData(page: Int, status: String, districtId: Int?) {
        Loader.start()
        let getList = ListService()
        getList.listPackages(model: ListPackagesRequest(id: itemId, page: currentPage, status: status, toDistrictId: districtId)) { result in
            switch result {
            case.success(let content):
                Loader.stop()
                guard let data = content.data else {return}
                self.dates.append(contentsOf: data)
                self.totalItems = content.meta?.total ?? 0
                self.emptyView(view: self.emptyView, count: self.dates.count)
                self.tableView.reloadData()
            case.failure(let error):
                Loader.stop()
                Alert.showAlert(forState: .error, message: error.localizedDescription, vibrationType: .error)
            }
        }
    }
    
    
    @IBAction func filterClearTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: [.curveEaseOut], animations: {
            self.filterSubView.transform = CGAffineTransform.identity.scaledBy(x: 0.5, y: 0.5)
            self.filterSubView.alpha = 0
            self.filterView.isHidden = true
        })
    }
    
    @IBAction func filterTapped(_ sender: UIButton) {
        self.filterView.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.6, options: [.curveEaseIn], animations: {
            self.filterSubView.transform = .identity
            self.filterSubView.alpha = 1
            
        }, completion: nil)
    }
    
    @IBAction func filterDissmissTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: [.curveEaseOut], animations: {
            self.filterSubView.transform = CGAffineTransform.identity.scaledBy(x: 0.5, y: 0.5)
            self.filterSubView.alpha = 0
            self.filterView.isHidden = true
        })
    }
}

//MARK: - Table View Delegate
extension ListVC: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostInsideTVC.identifier, for: indexPath) as? PostInsideTVC else {return UITableViewCell()}
        if indexPath.row == 0 {
            cell.headerDateLbl.isHidden = false
        }else{
            let first = dates[indexPath.row-1].created_at
            let second = dates[indexPath.row].created_at
            if first?.prefix(10) == second?.prefix(10){
                cell.headerDateLbl.isHidden = true
            }else{
                cell.headerDateLbl.isHidden = false
            }
        }
        cell.updateCellListData(data: self.dates[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let v = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 40))
        v.backgroundColor = UIColor(named: "primary900")
        let layout = UICollectionViewFlowLayout()
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
        return 40
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = tableView.tableHeaderView as? SkretchableHeaderView else{
            return
        }
        header.crollViewDidScroll(scrollView: tableView)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == dates.count - 1 {
            if self.totalItems > dates.count {
                self.currentPage += 1
                self.uploadData(page: self.currentPage, status: itemStatus, districtId: districtId)
            }
        }
    }
}


//MARK: - Collection View Delegate
extension ListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == filterCollectionView {
            return districtDtaes.count
        } else {
            return headerTexts.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == filterCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCVC", for: indexPath) as? ItemCVC else {return UICollectionViewCell()}
            cell.updateCell(data: self.districtDtaes[indexPath.row])
            return cell
        } else {
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
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == filterCollectionView {
            self.dates.removeAll()
            self.currentPage = 1
            self.tableView.reloadData()
            UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: [.curveEaseOut], animations: {
                self.filterSubView.transform = CGAffineTransform.identity.scaledBy(x: 0.5, y: 0.5)
                self.filterSubView.alpha = 0
                self.filterView.isHidden = true
            })
            self.districtId = self.districtDtaes[indexPath.row].id ?? 0
            uploadData(page: self.currentPage, status: itemStatus, districtId: districtId)
        } else {
            self.selectIndexCVC = indexPath.row
            if indexPath.row == 0 {
                updateStatus(status: "active")
            } else if indexPath.row == 1 {
                updateStatus(status: "completed")
            } else {
                updateStatus(status: "canceled")
            }
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == filterCollectionView {
            return CGSize(width: (self.districtDtaes[indexPath.row].name?.widthOfStringg(usingFont: .systemFont(ofSize: 15)) ?? 0) + 25, height: 40)
        } else {
            return CGSize(width: self.headerTexts[indexPath.row].widthOfStringg(usingFont: .systemFont(ofSize: 15)) + 25, height: 40)
        }
    }
    
}

extension ListVC {
    func updateStatus(status: String) {
        self.itemStatus = status
        self.currentPage = 1
        self.dates.removeAll()
        self.tableView.reloadData()
        self.emptyView.isHidden = true
        self.uploadData(page: self.currentPage, status: self.itemStatus, districtId: districtId)
    }
}

extension UIViewController {
    func emptyView(view: UIView, count: Int) {
        if count == 0 {
            view.isHidden = false
        } else {
            view.isHidden = true
        }
    }
}



