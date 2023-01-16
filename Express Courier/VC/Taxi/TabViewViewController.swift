//
//  TabViewViewController.swift
//  Express Courier
//
//  Created by Sherzod on 16/01/23.
//
import UIKit
import TabPageViewController

class TabViewViewController: TabPageViewController {
    
    override init() {
        super.init()
        title = "Taksi"
        navigationItem.title = "Taksi"
        option.currentColor = UIColor(red: 246/255, green: 175/255, blue: 32/255, alpha: 1.0)
        option.tabMargin = 60.0
        option.tabHeight = 50
        option.hidesTopViewOnSwipeType = .navigationBar
        option.tabBackgroundColor.accessibilityNavigationStyle = .automatic
        option.pageBackgoundColor = .red
        option.isTranslucent.toggle()
        option.isTranslucent = false
        let vc1 = TaxiVC()
        let vc2 = TaxiVC()
        let navVc1 = UINavigationController.init(rootViewController: vc1)
        let navVc2 = UINavigationController.init(rootViewController: vc2)
        tabItems = [(navVc1, "Yangilar"), (navVc2, "Ko'rilganlar")]
        isInfinity = false
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
