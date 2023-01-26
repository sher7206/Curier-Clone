import UIKit

class MainTabBarController: UITabBarController, UINavigationControllerDelegate, UIGestureRecognizerDelegate, UITabBarControllerDelegate {
    
    
    var canScrollToTop:Bool = true
    let vc1 = UINavigationController(rootViewController: PostVC())
    let vc2 = UINavigationController(rootViewController: TaxiVC())
    let vc3 = UINavigationController(rootViewController: TeamVC())
    let vc4 = UINavigationController(rootViewController: BranchesVC())
    let vc5 = UINavigationController(rootViewController: MyKabinetVC())
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        setupTabBArItems()
        tabBarController?.delegate = self
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)], for: .normal)
        
        if #available(iOS 15.0, *) {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.backgroundColor = .white
            tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.black]
            tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(named: "primary900")!]
            tabBar.standardAppearance = tabBarAppearance
            tabBar.scrollEdgeAppearance = tabBarAppearance
            
            
            
        }
    }
    
    // Called when the view becomes available
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        canScrollToTop = true
    }
    
    // Called when the view becomes unavailable
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        canScrollToTop = false
    }
    
    // Scrolls to top nicely
    
    
    
    func setupTabBArItems() {
        //Tabbar custumization
        
        tabBar.backgroundColor = .white
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 0.7
        //        tabBar.layer.shadowColor = UIColor(red: 13, green: 14, blue: 43, alpha: 1).cgColor
        tabBar.layer.shadowOpacity = 0.1
        
        
        //Setting Bar Items for ViewControllers
        vc1.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "box-menu")?.resized(to: CGSize(width: 25, height: 25)).withTintColor(UIColor(named: "black700")!, renderingMode: .alwaysOriginal), selectedImage: UIImage(named: "box-menu")?.resized(to: CGSize(width: 25, height: 25)).withTintColor(UIColor(named: "primary900")!, renderingMode: .alwaysOriginal))
        vc1.tabBarItem.title = "Pochta"
        
        vc2.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "car-menu")?.resized(to: CGSize(width: 25, height: 25)).withTintColor(UIColor(named: "black700")!, renderingMode: .alwaysOriginal), selectedImage: UIImage(named: "car-menu")?.resized(to: CGSize(width: 25, height: 25)).withTintColor(UIColor(named: "primary900")!, renderingMode: .alwaysOriginal))
        vc2.tabBarItem.title = "Taksi"
        
        vc3.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "people-menu")?.resized(to: CGSize(width: 25, height: 25)).withTintColor(UIColor(named: "black700")!, renderingMode: .alwaysOriginal), selectedImage: UIImage(named: "people-menu")?.resized(to: CGSize(width: 25, height: 25)).withTintColor(UIColor(named: "primary900")!, renderingMode: .alwaysOriginal))
        vc3.tabBarItem.title = "Jamoa"
        
        vc4.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "building-menu")?.resized(to: CGSize(width: 25, height: 25)).withTintColor(UIColor(named: "black700")!, renderingMode: .alwaysOriginal), selectedImage: UIImage(named: "building-menu")?.resized(to: CGSize(width: 25, height: 25)).withTintColor(UIColor(named: "primary900")!, renderingMode: .alwaysOriginal))
        vc4.tabBarItem.title = "Filliallar"
        
        vc5.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person")?.resized(to: CGSize(width: 25, height: 25)).withTintColor(UIColor(named: "black700")!, renderingMode: .alwaysOriginal), selectedImage: UIImage(systemName: "person")?.resized(to: CGSize(width: 25, height: 25)).withTintColor(UIColor(named: "primary900")!, renderingMode: .alwaysOriginal))
        vc5.tabBarItem.title = "Kabinet"
        
        viewControllers = [vc1,vc2,vc3,vc4,vc5]
    }
}

