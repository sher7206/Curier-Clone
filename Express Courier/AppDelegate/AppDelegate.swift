
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
        registerForPushNotifications()
        UINavigationBar.appearance().tintColor = .black
        window?.makeKeyAndVisible()
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    
}


// MARK: - Delegates
extension AppDelegate: UNUserNotificationCenterDelegate {
    
 
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if #available(iOS 14.0, *) {
            completionHandler([[.banner, .sound, .badge]])
        } else {
            completionHandler([[.alert, .sound, .badge]])
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        process(response.notification)
        completionHandler()
    }
    
    
    
    private func process(_ notification: UNNotification) {
        let userInfo = notification.request.content.userInfo
        NotificationCenter.default.post(name: Notification.Name(Keys.notificationName), object: nil, userInfo: userInfo)
    }
    
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        guard let fcmToken = fcmToken else { return }
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
