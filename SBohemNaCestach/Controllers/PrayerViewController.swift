//
//  PrayerViewController.swift
//  SBohemNaCestach
//
//  Created by Petr Hracek on 29/10/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import UIKit

class PrayerViewController: BaseViewController {

    // MARK: - Properties
    
    var prayerTitle: String = ""
    var prayer: String = ""


    @IBOutlet var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var innerContentView: UIView!
    @IBOutlet weak var prayerLabel: UILabel!
    // MARK: View controller lifecycle
    
    var back: UIColor = .black
    var text: UIColor = .white
    var darkMode: Bool = false
    var font_name: String = "Helvetica"
    var font_size: CGFloat = 16
    override func viewDidLoad() {
        super.viewDidLoad()
        title = prayerTitle
        let userDefaults = UserDefaults.standard
        prayerLabel.sizeToFit()
        prayerLabel.numberOfLines = 0
        prayerLabel.textAlignment = NSTextAlignment.left
        if let saveFontName = userDefaults.string(forKey: "FontName") {
            self.font_name = saveFontName
        } else {
            userDefaults.set("Helvetica", forKey: "FontName")
        }
        if let saveFontSize = userDefaults.string(forKey: "FontSize") {
            guard let n = NumberFormatter().number(from: saveFontSize) else { return }
            self.font_size = CGFloat(truncating: n)
        } else {
            userDefaults.set(16, forKey: "FontSize")
            self.font_size = 16
        }
        prayerLabel.attributedText = generateContent(text: prayer, font_name: self.font_name, size: self.font_size)
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
}
