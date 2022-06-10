//
//  AppDelegate.swift
//  SBohemNaCestach
//
//  Created by Petr Hracek on 16/10/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        PrayersDataService.shared.loadData()
        
        UITabBar.appearance().barTintColor = UIColor.WithGodOnRoad.titleColor()
        UITabBar.appearance().tintColor = UIColor.WithGodOnRoad.textNightColor()
        UITabBar.appearance().unselectedItemTintColor = .black
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().backgroundColor = UIColor.WithGodOnRoad.titleColor()
        
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.WithGodOnRoad.titleColor()
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.WithGodOnRoad.textNightColor()]
            UINavigationBar.appearance().backgroundColor = UIColor.WithGodOnRoad.titleColor()
            UINavigationBar.appearance().barTintColor = UIColor.WithGodOnRoad.textNightColor()
            UINavigationBar.appearance().isTranslucent = false
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
        else {
            UINavigationBar.appearance().barTintColor = UIColor.WithGodOnRoad.titleColor()
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.WithGodOnRoad.titleColor()]
            UINavigationBar.appearance().isTranslucent = false
        }
        return true
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return
    }

}

