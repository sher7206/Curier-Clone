//
//  SceneDelegate.swift
//  Express Courier
//
//  Created by apple on 22/01/23.
//

import UIKit

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        setupLaunch(scene)
        if let response = connectionOptions.notificationResponse {
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                
            NotificationCenter.default.post(name: NSNotification.Name(Keys.notificationName), object: nil, userInfo: response.notification.request.content.userInfo)
                
            }
        }
        guard let url = connectionOptions.urlContexts.first?.url else { return }
        handleURL(url: url)
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
        handleURL(url: url)
//        ApplicationDelegate.shared.application( UIApplication.shared, open: url, sourceApplication: nil, annotation: [UIApplication.OpenURLOptionsKey.annotation])
    }
    
    func setupLaunch(_ scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        if Cache.share.getUserToken() == nil {
            let vc = OnboardingVC()
            window?.rootViewController = vc
        } else {
            if Cache.share.getUserPassword() == nil {
                let vc = MainTabBarController()
                window?.rootViewController = vc
            } else {
                let vc = LockScreenVC()
                window?.rootViewController = vc
            }
        }
        window?.makeKeyAndVisible()
    }
    
    func handleURL(url: URL) {
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    func sceneWillResignActive(_ scene: UIScene) {
    }
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}
