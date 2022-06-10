//
//  PrayerViewController.swift
//  SBohemNaCestach
//
//  Created by Petr Hracek on 29/10/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import UIKit

class PrayerViewController: UIViewController, UIGestureRecognizerDelegate {

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

    override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsHorizontalScrollIndicator = false
        return sv
    }()
    
    lazy var innerContentView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    lazy var prayerLabel: UILabel = {
        let kp = UILabel()
        kp.translatesAutoresizingMaskIntoConstraints = false
        kp.numberOfLines = 0
        kp.lineBreakMode = .byWordWrapping
        return kp
    }()

    // MARK: View controller lifecycle
    
    var back: UIColor = .black
    var text: UIColor = .white
    var darkMode: Bool = false
    var font_name: String = "Helvetica"
    var font_size: String = "16"
    let keys = SettingsBundleHelper.SettingsBundleKeys.self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = prayerTitle
        prayerLabel.sizeToFit()
        prayerLabel.numberOfLines = 0
        prayerLabel.textAlignment = NSTextAlignment.left
        update_fonts()
        setupView()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
        let userDefaults = UserDefaults.standard
        self.darkMode = userDefaults.bool(forKey: keys.night)
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
    func setupView() {
        self.view.addSubview(innerContentView)
        innerContentView.addSubview(scrollView)
        scrollView.addSubview(prayerLabel)
        self.view.addConstraintsWithFormat(format: "H:|-5-[v0]-5-|", views: innerContentView)
        self.view.addConstraintsWithFormat(format: "V:|[v0]|", views: innerContentView)
        innerContentView.addConstraintsWithFormat(format: "H:|[v0]|", views: scrollView)
        innerContentView.addConstraintsWithFormat(format: "V:|[v0]|", views: scrollView)
        scrollView.addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: prayerLabel)
        scrollView.widthAnchor.constraint(equalTo: prayerLabel.widthAnchor, constant: 20).isActive = true
        scrollView.addConstraintsWithFormat(format: "V:|-10-[v0]-10-|", views: prayerLabel)
    }
    
    func refresh_ui() {
        self.view.backgroundColor = self.back
        self.prayerLabel.backgroundColor = self.back
        self.prayerLabel.textColor = self.text
        self.view.backgroundColor = self.back
        self.scrollView.backgroundColor = self.back
        self.innerContentView.backgroundColor = self.back
    }
    func toggleNavigationBarVisibility() {
        if let isNarBarHidden = navigationController?.isNavigationBarHidden {
            print(isNarBarHidden)
            if !isNarBarHidden { // It's necessary to hide the status bar before  nav bar hidding (because of a jump of content)...
                isStatusBarHidden = !isNarBarHidden
            }
            navigationController?.setNavigationBarHidden(!isNarBarHidden, animated: true)
            if isNarBarHidden { // ... and it's necessary to show the status bar after nav bar showing (because of a jump of content).
                isStatusBarHidden = !isNarBarHidden
            }
            print(isStatusBarHidden)
        }
    }
    @objc func didTapOnScreen() {
        toggleNavigationBarVisibility()
    }
    
    func setupUI() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapOnScreen))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    func update_fonts() {
        let userDefaults = UserDefaults.standard
        if userDefaults.bool(forKey: keys.serifEnabled) {
            self.font_name = "Times New Roman"
        }
        
        if let saveFontSize = userDefaults.string(forKey: keys.fontSize) {
            self.font_size = saveFontSize
        }
        prayerLabel.attributedText = generateContent(text: prayer, font_name: self.font_name, size: get_cgfloat(size: self.font_size))
    }
}
