
//  AppDelegate.swift
//  Express Courier
//  Created by apple on 04/01/23.

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        window = UIWindow()
        if Cache.share.getUserToken() == nil {
            let vc = OnboardingVC()
            window?.rootViewController = vc
        } else {
            let vc = MainTabBarController()
            window?.rootViewController = vc
        }
        UINavigationBar.appearance().tintColor = .black
        window?.makeKeyAndVisible()
        return true
    }
    
    
}

