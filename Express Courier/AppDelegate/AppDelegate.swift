
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
        print("Get user token =", Cache.share.getUserToken())
        if Cache.share.getUserToken() == nil {
            let vc = OnboardingVC()
            window?.rootViewController = vc
        } else {
            let vc = MainTabBarController()
            window?.rootViewController = vc
        }
        
        window?.makeKeyAndVisible()
        UINavigationBar.appearance().tintColor = .black
        return true
    }
}

