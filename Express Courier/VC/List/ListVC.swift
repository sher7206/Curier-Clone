
//  ListVC.swift
//  Express Courier
//  Created by Sherzod on 13/01/23.

import UIKit

class ListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(TaxiFilterTVC.nib(), forCellReuseIdentifier: TaxiFilterTVC.identifier)
            tableView.register(PostInsideTVC.nib(), forCellReuseIdentifier: PostInsideTVC.identifier)
            tableView.separatorStyle = .none
            if #available(iOS 15.0, *) { tableView.sectionHeaderTopPadding = 0 } else {}
        }
    }
    
    let search = UISearchController(searchResultsController: nil)
    let headerTexts = ["Yo'lda", "Yetkazilgan", "Bekor qilingan"]
    var selectIndexCVC: Int = 0
    var menuItems: [UIAction] {
        return [
            UIAction(title: "Statistika", image: UIImage(named: "diagram-list"), handler: { (_) in
                let vc = DistributionVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }),
            UIAction(title: "Hisoblash", image: UIImage(named: "math-list"), handler: { (_) in
                let vc = ReportVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }),
            UIAction(title: "Taqsimlash", image: UIImage(named: "discount-circle-list"), handler: { (_) in
                let vc = SortVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }),
            UIAction(title: "Jurnal", image: UIImage(named: "note-list"), handler: { (_) in
            })
        ]
    }
    var demoMenu: UIMenu {
        return UIMenu(title: "", image: UIImage(named: "more-list"), identifier: nil, options: [], children: menuItems)
    }
    var backColor: UIColor =  UIColor(named: "primary900")!
    var backWhiteColor: UIColor = UIColor(named: "white300")!
    
    var dates: [ListPackagesData] = []
    var itemId: Int = 59
    var itemStatus: String = "active"
    var currentPage: Int = 1
    var totalItems: Int = 0
    var itemTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = search
        setupNavigation()
        setUpScretchView()
        uploadData(page: self.currentPage)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func setUpScretchView(){
        let header = SkretchableHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 1))
        header.v.backgroundColor = UIColor(named: "primary900")
        tableView.tableHeaderView = header
        self.view.backgroundColor = UIColor(named: "white300")
    }
    
    func setupNavigation() {
        navigationItem.title = self.itemTitle
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "primary900")
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.backButtonTitle = ""
        if #available(iOS 14.0, *) {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", image: UIImage(named: "more-list"), primaryAction: nil, menu: demoMenu)
        } else {
            // Fallback on earlier versions
        }
    }
    
    func uploadData(page: Int) {
        Loader.start()
        let getList = ListService()
        getList.listPackages(model: ListPackagesRequest(id: itemId, page: currentPage, status: itemStatus)) { result in
            switch result {
            case.success(let content):
                Loader.stop()
                guard let data = content.data else {return}
                self.dates.append(contentsOf: data)
                self.totalItems = content.meta?.total ?? 0
                self.tableView.reloadData()
            case.failure(let error):
                Loader.stop()
                Alert.showAlert(forState: .error, message: error.localizedDescription, vibrationType: .error)
            }
        }
    }
    
}

//MARK: - Table View Delegate
extension ListVC: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostInsideTVC.identifier, for: indexPath) as? PostInsideTVC else {return UITableViewCell()}
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = tableView.tableHeaderView as? SkretchableHeaderView else{
            return
        }
        header.crollViewDidScroll(scrollView: tableView)
    }
    
}


//MARK: - Collection View Delegate
extension ListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return headerTexts.count
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
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.headerTexts[indexPath.row].widthOfStringg(usingFont: .systemFont(ofSize: 15)) + 25, height: 40)
    }
    
}


