//
//  SettingsTableViewController.swift
//  SBohemNaCestach
//
//  Created by Petr Hracek on 11/11/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import Foundation
import UIKit
import BonMot

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var dimOffSwitchLabel: UILabel!
    @IBOutlet weak var fontPickerLabel: UILabel!
    @IBOutlet weak var dimOffSwitch: UISwitch!
    @IBOutlet weak var dimOffSwitchCell: UITableViewCell!
    @IBOutlet weak var fontCell: UITableViewCell!
    @IBOutlet weak var nightSwitch: UISwitch!
    @IBOutlet weak var nightSwitchCell: UITableViewCell!
    @IBOutlet weak var footLabel: UILabel!
    @IBOutlet weak var footSwitch: UISwitch!
    @IBOutlet weak var nightSwitchLabel: UILabel!
    @IBOutlet weak var footCell: UITableViewCell!
    @IBOutlet weak var labelExample: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    var darkMode: Bool = false
    var back: UIColor = .black
    var text: UIColor = .white
    var exampleText: String = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Etiam neque."
    var fontName: String = "Helvetica"
    var fontSize: String = "16"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDefaults = UserDefaults.standard
        self.fontName = userDefaults.string(forKey: "FootFont") ?? "Helvetica"
        self.fontSize = userDefaults.string(forKey: "FontSize") ?? "16"
        slider.setValue(Float(Int(self.fontSize)!), animated: true)
        labelExample.attributedText = generateContent(text: exampleText, font_name: self.fontName, size: get_cgfloat(size: self.fontSize))
        navigationController?.navigationBar.barTintColor = UIColor.WithGodOnRoad.titleColor()
        //navigationController?.navigationBar.barStyle = UIBarStyle.black;
        self.tableView.tableFooterView = UIView()
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .darkModeEnabled, object: nil)
        NotificationCenter.default.removeObserver(self, name: .darkModeDisabled, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let userDefaults = UserDefaults.standard
        nightSwitch.isOn = userDefaults.bool(forKey: "NightSwitch")
        if nightSwitch.isOn == true {
            self.back = UIColor.WithGodOnRoad.backNightColor()
            self.text = UIColor.WithGodOnRoad.textNightColor()
        }
        else {
            self.back = UIColor.WithGodOnRoad.backLightColor()
            self.text = UIColor.WithGodOnRoad.textLightColor()
        }
        refresh_ui()
        dimOffSwitch.isOn = userDefaults.bool(forKey: "DimmScreen")
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        self.fontSize = "\(Int(slider.value))"
        userDefaults.set(self.fontSize, forKey: "FontSize")
        labelExample.attributedText = generateContent(text: exampleText, font_name: self.fontName, size: get_cgfloat(size: self.fontSize))
    }
    
    @IBAction func footMode(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        if footSwitch.isOn == true {
            self.fontName = "Times New Roman"
        } else {
            self.fontName = "Helvetica"
            
        }
        userDefaults.set(self.fontName, forKey: "FootFont")
        labelExample.attributedText = generateContent(text: exampleText, font_name: self.fontName, size: get_cgfloat(size: self.fontSize))
    }
    
    @IBAction func funcDisableDisplay(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        if dimOffSwitch.isOn == true {
            UIApplication.shared.isIdleTimerDisabled = true
            userDefaults.set(true, forKey: "DimmScreen")
        }
        else {
            UIApplication.shared.isIdleTimerDisabled = false
            userDefaults.set(false, forKey: "DimmScreen")
        }
    }
    @IBAction func funcNightMode(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        if nightSwitch.isOn == true {
            userDefaults.set(true, forKey: "NightSwitch")
            NotificationCenter.default.post(name: .darkModeEnabled, object:nil)
            self.back = UIColor.WithGodOnRoad.backNightColor()
            self.text = UIColor.WithGodOnRoad.textNightColor()
        }
        else {
            userDefaults.set(false, forKey: "NightSwitch")
            NotificationCenter.default.post(name: .darkModeDisabled, object: nil)
            self.back = UIColor.WithGodOnRoad.backLightColor()
            self.text = UIColor.WithGodOnRoad.textLightColor()
        }
        refresh_ui()
    }
    
    func refresh_ui() {
        self.view.backgroundColor = self.back
        self.dimOffSwitch.backgroundColor = self.back
        self.dimOffSwitchLabel.backgroundColor = self.back
        self.dimOffSwitchLabel.textColor = self.text
        self.dimOffSwitchCell.backgroundColor = self.back
        self.nightSwitch.backgroundColor = self.back
        self.nightSwitchLabel.backgroundColor = self.back
        self.nightSwitchLabel.textColor = self.text
        self.nightSwitchCell.backgroundColor = self.back
        self.fontCell.backgroundColor = self.back
        self.fontPickerLabel.backgroundColor = self.back
        self.fontPickerLabel.textColor = self.text
        self.labelExample.backgroundColor = self.back
        self.labelExample.textColor = self.text
    }
}
