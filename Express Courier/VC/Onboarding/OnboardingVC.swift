//
//  OnboardingVC.swift
//  Express Courier
//
//  Created by Sherzod on 05/01/23.
//

import UIKit
import SCPageControl

class OnboardingVC: UIViewController {
    

    @IBOutlet weak var sc: SCPageControlView!
    var nextLbl: String = ""
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var images: [String] = ["Illustration1-through", "Illustration2-through", "Illustration3"]
    var titles: [String] = ["Nima uchun biz ?", "Nima uchun biz ?", "Nima uchun biz ?"]
    var descriptionText: [String] = ["Kuryerlar uchun yuklarni ketkazishdagi muammolar yo‘q", "Kuryerlar uchun eng qulay va samarali usullardan foydalanamiz", "Kuryerlar uchun sifatli xizmatlar va doimiy yordam xizmati"]
    
    var currentPage: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sc.isCircle = true
        sc.scp_style = .SCNormal
        sc.set_view(3, current: 0, current_color: .black, disable_color: .black)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "OnboardingCVC", bundle: nil), forCellWithReuseIdentifier: "OnboardingCVC")
        
    }
    
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        if self.collectionView.contentOffset.x < self.view.bounds.width * 2 {
            let visibleItems: NSArray = self.collectionView.indexPathsForVisibleItems as NSArray
            let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
            let nextItem: IndexPath = IndexPath(item: currentItem.item + 1, section: 0)
            // This part here
            if nextItem.row < self.titles.count {
                self.collectionView.scrollToItem(at: nextItem, at: .left, animated: true)
                
            }
        } else {
            self.nextLbl = "Tushundim"
            let vc = PostVC()
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
            
        }
    }
    
}


extension OnboardingVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCVC", for: indexPath) as? OnboardingCVC else {return UICollectionViewCell()}
        cell.updateCell(title: self.titles[indexPath.row], desc: self.descriptionText[indexPath.row], img: self.images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = Int(round(scrollView.contentOffset.x / view.frame.width))
        sc.scroll_did(scrollView)
        self.currentPage = pageIndex
        if currentPage == 2 {
            nextLbl = "Tushundim"
        } else {
            nextLbl = "Keyingisi"
        }
    }
    
}
