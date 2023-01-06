
//  PostVC.swift
//  Express Courier
//  Created by apple on 05/01/23.

import UIKit

class PostVC: UIViewController {

    @IBOutlet weak var fromRegionLbl: UILabel!
    @IBOutlet weak var toRegionLbl: UILabel!
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
            collectionView.register(PostInsideCVC.nib(), forCellWithReuseIdentifier: PostInsideCVC.identifier)
        }
    }
    
    let headerTexts = ["Buyurtmalar", "Yangi", "Qabul qilingan", "Yo'lda", "Yetkazilgan", "Bekor qilingan"]
    var selectedIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        title = "Pochta"
    }
    
    func setupNavigation(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "primary900")
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        let menuBtn = UIBarButtonItem(image: UIImage(named: "menu-list"), style: .plain, target: self, action: #selector(menuBtnPressed))
        navigationItem.leftBarButtonItem = menuBtn
        let filterBtn = UIBarButtonItem(image: UIImage(named: "filter-post"), style: .plain, target: self, action: #selector(filterBtnPressed))
        navigationItem.rightBarButtonItem = filterBtn
    }
    
    
    @objc func menuBtnPressed(){
        let vc = SideMenuVC(nibName: "SideMenuVC", bundle: nil)
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overFullScreen
        present(nav, animated: false, completion: nil)
    }
    
    @objc func filterBtnPressed(){
    }
    @IBAction func fromButtonPressed(_ sender: Any) {
    }
    @IBAction func toButtonPressed(_ sender: Any) {
    }
    @IBAction func fromDismissBtnPressed(_ sender: Any) {
    }
    @IBAction func toDismissBtnPressed(_ sender: Any) {
    }
    @IBAction func exchangeBtnPressed(_ sender: Any) {
    }

}

//MARK: Collection View
extension PostVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return headerTexts.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = headercollectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCVC", for: indexPath) as? HeaderCVC else {return UICollectionViewCell()}
        cell.lbl.text = self.headerTexts[indexPath.row]
        if selectedIndex == indexPath.row {
            cell.bottomView.backgroundColor = .white
        } else {
            cell.bottomView.backgroundColor = UIColor.clear
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        headercollectionView.reloadData()
        selectedIndex = indexPath.row
        self.headercollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == headercollectionView {
            return CGSize(width: self.headerTexts[indexPath.row].widthOfStringg(usingFont: .systemFont(ofSize: 15)) + 20, height: 50)
        } else {
            let w = self.collectionView.frame.width
            let h = self.collectionView.frame.height
            return CGSize(width: w, height: h)
        }
    }
    
}
