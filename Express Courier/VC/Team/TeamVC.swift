//
//  TeamVC.swift
//  Express Courier
//
//  Created by Sherzod on 12/01/23.
//

import UIKit

class TeamVC: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
    }
    
    
    
    @IBAction func addTeamTapped(_ sender: UIButton) {
        let vc = AddTeamVC()
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
}


//MARK: - Collection View Delegate
extension TeamVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCVC", for: indexPath) as? TeamCVC else {return UICollectionViewCell()}
        cell.delegate = self
        cell.index = indexPath.row
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.collectionView.frame.width - 16
        let itemWidth = width / 2
        return CGSize(width: itemWidth, height: itemWidth * 1.2)
    }
    
}

//MARK: - Funs
extension TeamVC {
    func setupNavigation() {
        title = "Jamoa"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "primary900")
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.backButtonTitle = ""
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "TeamCVC", bundle: nil), forCellWithReuseIdentifier: "TeamCVC")
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}

//MARK: - AddTeamVCDelegate
extension TeamVC: AddTeamVCDelegate {
    func addTeam() {
        print("Add bosildi!")
    }
}

//MARK: - Delete Item Delegate
extension TeamVC: TeamCVCDelegate {
    func deleteItem(index: Int) {
        let vc = DeleteTeamVC()
        vc.index = index
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
}

