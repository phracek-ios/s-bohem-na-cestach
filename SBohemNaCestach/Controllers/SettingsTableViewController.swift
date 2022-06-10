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
import FirebaseAnalytics

class SettingsTableViewController: UITableViewController {

//    @IBOutlet weak var dimOffSwitchLabel: UILabel!
//    @IBOutlet weak var fontPickerLabel: UILabel!
//    @IBOutlet weak var dimOffSwitch: UISwitch!
//    @IBOutlet weak var dimOffSwitchCell: UITableViewCell!
//    @IBOutlet weak var fontCell: UITableViewCell!
//    @IBOutlet weak var nightSwitch: UISwitch!
//    @IBOutlet weak var nightSwitchCell: UITableViewCell!
//    @IBOutlet weak var footLabel: UILabel!
//    @IBOutlet weak var footSwitch: UISwitch!
//    @IBOutlet weak var nightSwitchLabel: UILabel!
//    @IBOutlet weak var footCell: UITableViewCell!
//    @IBOutlet weak var labelExample: UILabel!
//    @IBOutlet weak var slider: UISlider!
    
    var settings = [SettingsItem]()
    let settingsDelegate = SettingsDelegateManager()
    var darkMode: Bool = false
    var back: UIColor = .black
    var text: UIColor = .white
    var exampleText: String = "Kdo mnoho cestoval, mnoho poznal."
    var fontName: String = ""
    var fontSize: String = "16"
    let userDefaults = UserDefaults.standard
    let keys = SettingsBundleHelper.SettingsBundleKeys.self

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor.WithGodOnRoad.titleColor()
        loadSettings()
        setupSettingsTable()
        self.tableView.tableFooterView = UIView()
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .darkModeEnabled, object: nil)
        NotificationCenter.default.removeObserver(self, name: .darkModeDisabled, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let userDefaults = UserDefaults.standard
        darkMode = userDefaults.bool(forKey: keys.night)
        if darkMode == true {
            self.back = UIColor.WithGodOnRoad.backNightColor()
            self.text = UIColor.WithGodOnRoad.textNightColor()
        }
        else {
            self.back = UIColor.WithGodOnRoad.backLightColor()
            self.text = UIColor.WithGodOnRoad.textLightColor()
        }
        self.fontSize = userDefaults.string(forKey: keys.fontSize) ?? "16"
        tableView.backgroundColor = self.back
        tableView.allowsSelection = false
        tableView.separatorColor = .gray
        tableView.tableFooterView = UIView()
        refresh_ui()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch settings[indexPath.row].type {
        case .slider:
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingsSliderTableViewCell.cellId, for: indexPath) as! SettingsSliderTableViewCell
            cell.configureCell(settingsItem: settings[indexPath.row],
                               delegate: settingsDelegate,
                               cellWidth: tableView.frame.width)
            cell.accessoryType = .none
            cell.backgroundColor = self.back
            return cell
//        case .text:
//            let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTextTableViewCell.cellId, for: indexPath) as! SettingsTextTableViewCell
//            cell.configureCell(settingsItem: settings[indexPath.row],
//                               cellWidth: tableView.frame.width)
//            cell.accessoryType = .disclosureIndicator
//            cell.backgroundColor = self.back
//            return cell
        default:
            let set = settings[indexPath.row]
            print(set.prefsString)
            let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
            
            let sw = UISwitch()
            sw.isOn = userDefaults.bool(forKey: set.prefsString)
            if set.prefsString == keys.night {
                sw.addTarget(self, action: #selector(nightTarget(_:)), for: .valueChanged)
            }
            else if set.prefsString == keys.idleTimer {
                sw.addTarget(self, action: #selector(idleTarget(_:)), for: .valueChanged)
            }
            else if set.prefsString == keys.serifEnabled {
                sw.addTarget(self, action: #selector(serifTarget(_:)), for: .valueChanged)
            }
            cell.textLabel?.text = settings[indexPath.row].title
            cell.detailTextLabel?.text = settings[indexPath.row].detail

            cell.backgroundColor = self.back
            cell.textLabel?.backgroundColor = self.back
            cell.textLabel?.textColor = self.text
            cell.detailTextLabel?.backgroundColor = self.back
            cell.detailTextLabel?.textColor = self.text

            cell.accessoryView = sw
            cell.accessoryType = .none
            return cell
        }
    }
    func setupSettingsTable() {
        tableView.register(SettingsSwitchTableViewCell.self, forCellReuseIdentifier: SettingsSwitchTableViewCell.cellId)
        tableView.register(SettingsSliderTableViewCell.self, forCellReuseIdentifier: SettingsSliderTableViewCell.cellId)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
    }
    
    @objc func serifTarget(_ sender: UISwitch) {
        print("Serif Target \(sender.isOn)")
        userDefaults.set(sender.isOn, forKey: keys.serifEnabled)
    }
    
    @objc func idleTarget(_ sender: UISwitch) {

        print("Idle Target Night \(sender.isOn)")
        userDefaults.set(sender.isOn, forKey: keys.idleTimer)
        
    }
    @objc func nightTarget(_ sender: UISwitch) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(sender.isOn, forKey: keys.night)
        self.darkMode = sender.isOn
        if sender.isOn == true {
            NotificationCenter.default.post(name: .darkModeEnabled, object:nil)
            self.back = UIColor.WithGodOnRoad.backNightColor()
            self.text = UIColor.WithGodOnRoad.textNightColor()
        }
        else {
            NotificationCenter.default.post(name: .darkModeDisabled, object: nil)
            self.back = UIColor.WithGodOnRoad.backLightColor()
            self.text = UIColor.WithGodOnRoad.textLightColor()
        }
        refresh_ui()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func loadSettings() {
        settings.append(SettingsItem(type: SettingsItemType.onOffSwitch,
                                    title: "Blokovat zhasínání displeje",
                                    description: "",
                                    prefsString: keys.idleTimer,
                                    defValue: false,
                                    eventHandler: nil))
        settings.append(SettingsItem(type: SettingsItemType.onOffSwitch,
                                     title: "Noční režim",
                                     description: "",
                                     prefsString: keys.night,
                                     defValue: false,
                                     eventHandler: nil))
        settings.append(SettingsItem(type: SettingsItemType.onOffSwitch,
                                 title: "Patkové písmo",
                                 description: "",
                                 prefsString: keys.serifEnabled,
                                 defValue: false,
                                 eventHandler: nil))
        settings.append(SettingsItem(type: SettingsItemType.slider,
                                 title: "Velikost písma",
                                 description: "Velikost písma, které bude použito u modliteb.",
                                 prefsString: keys.fontSize,
                                 defValue: false,
                                 eventHandler: nil))
        print("loadSettings finished")
    }
    
    func refresh_ui() {
        self.view.backgroundColor = self.back
    }
}
