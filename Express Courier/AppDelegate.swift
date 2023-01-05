
//  AppDelegate.swift
//  Express Courier
//  Created by apple on 04/01/23.

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        let vc = OnboardingVC()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }

}

