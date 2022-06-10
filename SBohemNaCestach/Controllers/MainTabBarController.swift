//
//  MainTabBarController.swift
//  SBohemNaCestach
//
//  Created by Petr Hracek on 31.05.2022.
//  Copyright © 2022 Petr Hracek. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "S Bohem na cestách"
        print("MainTabBarController")
        let prayerTableViewController = PrayersTableViewController()
        prayerTableViewController.tabBarItem = UITabBarItem(title: "Domů", image: UIImage(named: "ic_home"), tag: 0)

        let infoViewController = InfoViewController()
        infoViewController.tabBarItem = UITabBarItem(title: "Info", image: UIImage(named: "ic_info"), tag: 1)
        
        let aboutViewController = AboutApplViewController()
        aboutViewController.tabBarItem = UITabBarItem(title: "O aplikaci", image: UIImage(named: "ic_question"), tag: 2)
        
        let settingsTableViewController = SettingsTableViewController()
        settingsTableViewController.tabBarItem = UITabBarItem(title: "Nastavení", image: UIImage(named: "ic_settings"), tag: 3)
        
        let tabBarList = [prayerTableViewController, infoViewController, aboutViewController, settingsTableViewController]
        
        viewControllers = tabBarList
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.WithGodOnRoad.mainColor()]
        navigationController?.navigationBar.barStyle = UIBarStyle.black;
        navigationController?.navigationBar.backItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

    }
    
    // MARK: - Navigation
}
