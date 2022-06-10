//
//  SettingsDelegateManager.swift
//  SBohemNaCestach
//
//  Created by Petr Hracek on 09.06.2022.
//  Copyright © 2022 Petr Hracek. All rights reserved.
//

import Foundation
import UIKit

protocol SettingsDelegate {
    func settingsChangeDelegate(item: SettingsItem, newValue: Any?)
}

class SettingsDelegateManager: SettingsDelegate {
    
    let keys = SettingsBundleHelper.SettingsBundleKeys.self
    
    func settingsChangeDelegate(item: SettingsItem, newValue: Any?) {
        print("settingsChangeDelegate: \(item.prefsString) (new state: \(UserDefaults.standard.object(forKey: item.prefsString) ?? "DEFVAL")")
        
        if item.prefsString == keys.idleTimer {
            if let enable : Bool = newValue as? Bool {
                UIApplication.shared.isIdleTimerDisabled = enable
            }
        }
        
    }
        
}
