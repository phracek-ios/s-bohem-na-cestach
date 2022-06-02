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
        UINavigationBar.appearance().barTintColor = UIColor.WithGodOnRoad.titleColor()
        //UINavigationBar.appearance().tintColor = UIColor.WithGodOnRoad.textNightColor()
        UINavigationBar.appearance().isTranslucent = false
        return true
    }

}

