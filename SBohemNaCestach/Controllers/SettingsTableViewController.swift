//
//  SettingsTableViewController.swift
//  SBohemNaCestach
//
//  Created by Petr Hracek on 11/11/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import UIKit
import BonMot
import Foundation

class SettingsTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var fontNamePickerView: UIPickerView!
    @IBOutlet weak var dimOffSwitchLabel: UILabel!
    @IBOutlet weak var fontPickerLabel: UILabel!
    @IBOutlet weak var dimOffSwitch: UISwitch!
    @IBOutlet weak var dimOffSwitchCell: UITableViewCell!
    @IBOutlet weak var fontCell: UITableViewCell!
    @IBOutlet weak var nightSwitch: UISwitch!
    @IBOutlet weak var nightSwitchCell: UITableViewCell!
    @IBOutlet weak var nightSwitchLabel: UILabel!
    
    var pickerData: [[String]] = [[String]]()
    var darkMode: Bool = false
    var back: UIColor = .black
    var text: UIColor = .white
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDefaults = UserDefaults.standard
        let fontNames: [String] = [
            "Arial", "Helvetica", "Times New Roman", "Baskerville", "Didot", "Gill Sans", "Hoefler Text", "Palatino", "Trebuchet MS", "Verdana"
        ]
        self.fontNamePickerView.delegate = self
        self.fontNamePickerView.dataSource = self
        let fontSizes: [String] = ["14", "16", "18", "20", "22", "24", "26", "28", "30"]
        pickerData = [fontNames, fontSizes]
        var fontName = userDefaults.string(forKey: "FontName")
        var fontSize = userDefaults.string(forKey: "FontSize")
        if fontName == nil {
            fontName = "Helvetica"
        }
        if fontSize == nil {
            fontSize = "14"
        }

        self.fontNamePickerView.selectRow(fontNames.firstIndex(of: fontName!)!, inComponent: 0, animated: true)
        self.fontNamePickerView.selectRow(fontSizes.firstIndex(of: fontSize!)!, inComponent: 1, animated: true)
        navigationController?.navigationBar.barStyle = UIBarStyle.black;
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
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerData[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributes = [NSAttributedString.Key.foregroundColor: self.text]
        return NSAttributedString(string: self.pickerData[component][row], attributes: attributes)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let userDefaults = UserDefaults.standard
        let fontName = pickerData[0][pickerView.selectedRow(inComponent: 0)]
        let fontStr = pickerData[1][pickerView.selectedRow(inComponent: 1)]
        guard let n = NumberFormatter().number(from: fontStr) else { return }
        userDefaults.set(fontStr, forKey: "FontSize")
        userDefaults.set(fontName, forKey: "FontName")
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
        self.fontNamePickerView.backgroundColor = self.back
    }
}
