
//  AppDelegate.swift
//  Express Courier
//  Created by apple on 04/01/23.

import UIKit
import IQKeyboardManagerSwift
import XNLogger

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        NetworkMonitor.shared.startMonitoring()
        
        window = UIWindow()
        print("Get user token =", Cache.share.getUserToken())
        XNLogger.shared.startLogging()

        let abc = UserService()
        let img = UIImage(systemName: "person")
        let imgData = img?.pngData()
        guard let imageData = imgData else {return true}
        abc.becomeCourier(passportData: imageData, passport: "passport", pravaData: imageData, prava: "drivers_license", transport_type: "on_car") { result in
            switch result {
            case.success(let content):
                print(content)
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
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

