
//  ListVC.swift
//  Express Courier
//  Created by Sherzod on 13/01/23.

import UIKit

class ListVC: UIViewController {
    

    @IBOutlet weak var headercollectionView: UICollectionView!{
        didSet{
            headercollectionView.delegate = self
            headercollectionView.dataSource = self
            headercollectionView.register(UINib(nibName: "HeaderCVC", bundle: nil), forCellWithReuseIdentifier: "HeaderCVC")
            headercollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(PostCVC.nib(), forCellWithReuseIdentifier: PostCVC.identifier)
        }
    }
    
    let search = UISearchController(searchResultsController: nil)
    let headerTexts = ["Buyurtmalar", "Yangi", "Qabul qilingan"]
    var selectedIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = search
        setupNavigation()
    }
    
    func setupNavigation() {
        title = "Bon-Ton store"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "primary900")
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.backButtonTitle = ""
    }
    
}

//MARK: Collection View
extension ListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return headerTexts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.headercollectionView{
            
            guard let cell = headercollectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCVC", for: indexPath) as? HeaderCVC else {return UICollectionViewCell()}
            cell.lbl.text = self.headerTexts[indexPath.row]
            if selectedIndex == indexPath.row {
                cell.lbl.textColor = .black
                cell.bottomView.backgroundColor = .black
            } else {
                cell.lbl.textColor = UIColor(named: "black600")
                cell.bottomView.backgroundColor = UIColor.clear
            }
            return cell
            
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCVC.identifier, for: indexPath) as! PostCVC
           // cell.delegate = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        headercollectionView.reloadData()
        selectedIndex = indexPath.row
        self.headercollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == headercollectionView {
            return CGSize(width: self.headerTexts[indexPath.row].widthOfStringg(usingFont: .systemFont(ofSize: 15)) + 20, height: 40)
        } else {
            let w = self.collectionView.frame.width
            let h = self.collectionView.frame.height
            return CGSize(width: w, height: h)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navigationItem.hidesSearchBarWhenScrolling = false
        if scrollView == self.collectionView{
            headercollectionView.reloadData()
            let pageIndex = Int(round(scrollView.contentOffset.x / view.frame.width))
            self.selectedIndex = pageIndex
            self.headercollectionView.scrollToItem(at: IndexPath(row: selectedIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
}
