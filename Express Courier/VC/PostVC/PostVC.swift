
//  PostVC.swift
//  Express Courier
//  Created by apple on 05/01/23.

import UIKit
class PostVC: UIViewController {

    @IBOutlet weak var fromRegionLbl: UILabel!
    @IBOutlet weak var toRegionLbl: UILabel!
    
    @IBOutlet weak var regionView: UIView!
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
    
    let headerTexts = ["Buyurtmalar", "Yangi", "Qabul qilingan", "Yo'lda", "Yetkazilgan", "Bekor qilingan"]
    var selectedIndex: Int = 0

    var scrollHegight = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        title = "Pochta"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(onNotificationCatched(notification:)), name: NSNotification.Name(rawValue: "scrollNav"), object: nil)
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
    
    
    
    @objc func onNotificationCatched(notification:NSNotification) {
        
        let userInfo:Dictionary<String, Double > = notification.userInfo as! Dictionary<String, Double>
        
        let value = userInfo["height"]! as! Double
            
        if value <= 0{
            regionView.isHidden = false
        }else{
            regionView.isHidden = true
        }
        collectionView.reloadData()
    }
    
    
    @objc func menuBtnPressed(){
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
    @IBAction func scanBtnPressed(_ sender: Any) {
    }
    @IBAction func listBtnPressed(_ sender: Any) {
    }
    
}

//MARK: Collection View
extension PostVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
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
            cell.delegate = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView{
            
        }
        
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.collectionView{
            headercollectionView.reloadData()
            let pageIndex = Int(round(scrollView.contentOffset.x / view.frame.width))
            self.selectedIndex = pageIndex
            self.headercollectionView.scrollToItem(at: IndexPath(row: selectedIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
}

//MARK: Delegate
extension PostVC: PostCVCDelegate{
    
    func didSelected(index: Int) {
        let vc = PostAgreemantVC()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
    }
    
    
}
