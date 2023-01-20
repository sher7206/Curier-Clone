
//  MainTabBarController.swift
//  Dems
//  Created by Fayozxon on 12/01/21.

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    private lazy var main: PostVC = {
        let vc = PostVC(nibName: "PostVC", bundle: nil)
        vc.tabBarItem = UITabBarItem(
            title: "Pochta",
            image: UIImage(named: "box-menu"),
            selectedImage: UIImage(named: "box-menu")
        )
        return vc
    }()
    
    
    private lazy var branch: BranchesVC = {
        let vc = BranchesVC(nibName: "BranchesVC", bundle: nil)
        vc.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "building-menu"),
            selectedImage: UIImage(named: "building-menu")
        )
        return vc
    }()
    
    private lazy var team: TeamVC = {
        let vc = TeamVC(nibName: "TeamVC", bundle: nil)
        vc.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "people-menu"),
            selectedImage: UIImage(named: "people-menu")
        )
        return vc
    }()
    
    private lazy var taxi: TaxiVC = {
        let vc = TaxiVC(nibName: "TaxiVC", bundle: nil)
        vc.tabBarItem = UITabBarItem(
            title: "Taksi",
            image: UIImage(named: "car-menu"),
            selectedImage: UIImage(named: "car-menu")
        )
        return vc
    }()

    private lazy var profile: MyKabinetVC = {
        let vc = MyKabinetVC(nibName: "MyKabinetVC", bundle: nil)
        vc.tabBarItem = UITabBarItem(
            title: "Kabinet",
            image: UIImage(named: "support-menu"),
            selectedImage: UIImage(named: "support-menu")
        )
        return vc
    }()

    //On tabbar viewDidload
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        viewControllers = [
            UINavigationController(rootViewController: main),
            UINavigationController(rootViewController: branch),
            UINavigationController(rootViewController: team),
            UINavigationController(rootViewController: taxi),
            UINavigationController(rootViewController: profile)
        ]
        
        tabBar.items![0].imageInsets = UIEdgeInsets(top: 3, left: 0, bottom: -3, right: 0)
        tabBar.items![1].imageInsets = UIEdgeInsets(top: 3, left: 0, bottom: -3, right: 0)
        tabBar.items![2].imageInsets = UIEdgeInsets(top: 3, left: 0, bottom: -3, right: 0)
        tabBar.items![3].imageInsets = UIEdgeInsets(top: 3, left: 0, bottom: -3, right: 0)
        tabBar.items![4].imageInsets = UIEdgeInsets(top: 3, left: 0, bottom: -3, right: 0)
        
        foriOS15()
       // tabBar.tintColor = UIColor(named: "blackWhite")
    }
    
    func foriOS15() {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactScrollEdgeAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            let appearance1 = UITabBarAppearance()
            appearance1.configureWithOpaqueBackground()
          //  appearance1.backgroundColor = UIColor(named: "newDarkBlack")
            self.tabBar.standardAppearance = appearance1
            self.tabBar.scrollEdgeAppearance = self.tabBar.standardAppearance
        }
    }
    
}

