
//  AppDelegate.swift
//  Express Courier
//  Created by apple on 04/01/23.

import UIKit
import IQKeyboardManagerSwift
import XNLogger
import Firebase
import FirebaseMessaging
import UserNotificationsUI
import UserNotifications


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let gcmMEssageIdKey = "gcm.Message_ID.express"

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        NetworkMonitor.shared.startMonitoring()
        
        window = UIWindow()
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self

        XNLogger.shared.startLogging()
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
        registerForPushNotifications()

        UINavigationBar.appearance().tintColor = .black
        window?.makeKeyAndVisible()
        return true
    }
}


// MARK: - Delegates
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        Messaging.messaging().appDidReceiveMessage(userInfo)
        
        if #available(iOS 14.0, *) {
            completionHandler([[.banner, .sound, .badge]])
        } else {
            completionHandler([[.alert, .sound, .badge]])
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print(userInfo," User info 🔄")
        Messaging.messaging().appDidReceiveMessage(userInfo)
        completionHandler()
    }

    private func process(_ notification: UNNotification) {
        _ = notification.request.content.userInfo
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        Messaging.messaging().appDidReceiveMessage(userInfo)
        if let messageID = userInfo[gcmMEssageIdKey]{
            print(messageID)
        }
        completionHandler(.newData)
    }
    
    
}

extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        guard let fcmToken = fcmToken else { return }
        let dataDict: [String: String] = ["token": fcmToken]
        NotificationCenter.default.post(
           name: Notification.Name("FCMToken"),
           object: nil,
           userInfo: dataDict
         )
        UserDefaults.standard.set(fcmToken, forKey: Keys.fcmToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error.localizedDescription)
    }
    

    
}


//MARK: - Other Func
extension AppDelegate {
    func registerForPushNotifications() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
                guard granted else { return }
                self.getNotificationSettings()
            }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
              UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
}
