//
//  PrayerViewController.swift
//  SBohemNaCestach
//
//  Created by Petr Hracek on 29/10/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import UIKit

class PrayerViewController: BaseViewController, UIGestureRecognizerDelegate {

    // MARK: - Properties
    
    var prayerTitle: String = ""
    var prayer: String = ""

    var isStatusBarHidden = false {
        didSet {
            UIView.animate(withDuration: 0.25) { () -> Void in
                self.setNeedsStatusBarAppearanceUpdate()
            }
        }
    }

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var innerContentView: UIView!
    @IBOutlet weak var prayerLabel: UILabel!
    // MARK: View controller lifecycle
    
    var back: UIColor = .black
    var text: UIColor = .white
    var darkMode: Bool = false
    var font_name: String = "Helvetica"
    var font_size: String = "16"
    override func viewDidLoad() {
        super.viewDidLoad()
        title = prayerTitle
        prayerLabel.sizeToFit()
        prayerLabel.numberOfLines = 0
        prayerLabel.textAlignment = NSTextAlignment.left
        update_fonts()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let userDefaults = UserDefaults.standard
        self.darkMode = userDefaults.bool(forKey: "NightSwitch")
        if self.darkMode == true {
            self.back = UIColor.WithGodOnRoad.backNightColor()
            self.text = UIColor.WithGodOnRoad.textNightColor()
        }
        else {
            self.back = UIColor.WithGodOnRoad.backLightColor()
            self.text = UIColor.WithGodOnRoad.textLightColor()
        }
        update_fonts()
        refresh_ui()
    }
    func refresh_ui() {
        self.view.backgroundColor = self.back
        self.prayerLabel.backgroundColor = self.back
        self.prayerLabel.textColor = self.text
        self.contentView.backgroundColor = self.back
        self.scrollView.backgroundColor = self.back
        self.innerContentView.backgroundColor = self.back
    }
    func toggleNavigationBarVisibility() {
        if let isNarBarHidden = navigationController?.isNavigationBarHidden {
            if !isNarBarHidden { // It's necessary to hide the status bar before  nav bar hidding (because of a jump of content)...
                isStatusBarHidden = !isNarBarHidden
            }
            navigationController?.setNavigationBarHidden(!isNarBarHidden, animated: true)
            if isNarBarHidden { // ... and it's necessary to show the status bar after nav bar showing (because of a jump of content).
                isStatusBarHidden = !isNarBarHidden
            }
        }
    }
    @objc func didTapOnScreen() {
        toggleNavigationBarVisibility()
    }
    
    func setupUI() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapOnScreen))
        tap.delegate = self
        view.addGestureRecognizer(tap)
        navigationController?.navigationBar.barTintColor = UIColor.WithGodOnRoad.titleColor()
    }
    
    func update_fonts() {
        let userDefaults = UserDefaults.standard
        if let saveFontName = userDefaults.string(forKey: "FootFont") {
            self.font_name = saveFontName
        } else {
            userDefaults.set("Helvetica", forKey: "FootFont")
            self.font_name = "Helvetica"
        }
        
        if let saveFontSize = userDefaults.string(forKey: "FontSize") {
            self.font_size = saveFontSize
        } else {
            userDefaults.set(16, forKey: "FontSize")
            self.font_size = "16"
        }
        prayerLabel.attributedText = generateContent(text: prayer, font_name: self.font_name, size: get_cgfloat(size: self.font_size))
    }
}
