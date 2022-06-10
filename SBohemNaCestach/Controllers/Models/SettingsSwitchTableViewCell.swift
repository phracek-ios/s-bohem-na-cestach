//
//  SettingsSwitchTableViewCell.swift
//  SBohemNaCestach
//
//  Created by Petr Hracek on 09.06.2022.
//  Copyright © 2022 Petr Hracek. All rights reserved.
//

import Foundation
import UIKit

class SettingsSwitchTableViewCell: UITableViewCell {

    static let cellId = "settingsSwitchItem"
    let keys = SettingsBundleHelper.SettingsBundleKeys.self
    
    var title: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 18)
        l.backgroundColor = .clear
        return l
    }()
    
    var detail: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14)
        l.numberOfLines = 0
        return l
    }()
    
    var itemSwitch = UISwitch()
    var delegate: SettingsDelegate?
    var backColor = UIColor.WithGodOnRoad.backLightColor()
    var labelColor = UIColor.WithGodOnRoad.textLightColor()
    var settingsItem: SettingsItem?
    
    func configureCell(settingsItem: SettingsItem, delegate: SettingsDelegate, cellWidth: CGFloat) {
        let userDefaults = UserDefaults.standard
        let darkMode = userDefaults.bool(forKey: keys.night)
        if darkMode == true {
            self.backColor = UIColor.WithGodOnRoad.backNightColor()
            self.labelColor = UIColor.WithGodOnRoad.textNightColor()
        }
        else {
            self.backColor = UIColor.WithGodOnRoad.backLightColor()
            self.labelColor = UIColor.WithGodOnRoad.textLightColor()
        }
        self.settingsItem = settingsItem
        self.delegate = delegate
        self.textLabel?.text = settingsItem.title
        self.accessoryView = itemSwitch
        title.text = settingsItem.title
        detail.text = settingsItem.detail

        backgroundColor = self.backColor
        selectionStyle = .none
        title.textColor = self.labelColor
        var isOn : Bool = (settingsItem.defValue as? Bool)!
        if UserDefaults.standard.object(forKey: settingsItem.prefsString) != nil {
            isOn = UserDefaults.standard.bool(forKey: settingsItem.prefsString)
        }
        itemSwitch.isOn = isOn
        
        itemSwitch.addTarget(self, action: #selector(self.switchTarget(_:)), for: .valueChanged)
        
    }

    @objc func switchTarget(_ sender: UISlider!) {
        //print("Switch Target")
        if settingsItem?.prefsString == keys.night {
            if itemSwitch.isOn == false {
                self.backgroundColor = UIColor.WithGodOnRoad.backLightColor()
                title.textColor = UIColor.WithGodOnRoad.textLightColor()
            }
            else {
                //title.backgroundColor = KKCBackgroundNightMode
                self.backgroundColor = UIColor.WithGodOnRoad.backNightColor()
                title.textColor = UIColor.WithGodOnRoad.textNightColor()
            }
        }
        UserDefaults.standard.set(itemSwitch.isOn,  forKey: settingsItem!.prefsString)
        if delegate != nil && settingsItem != nil {
            delegate?.settingsChangeDelegate(item: settingsItem!, newValue: itemSwitch.isOn)
        }
    }

}
