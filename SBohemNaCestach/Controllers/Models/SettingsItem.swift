//
//  SettingsItem.swift
//  SBohemNaCestach
//
//  Created by Petr Hracek on 09.06.2022.
//  Copyright © 2022 Petr Hracek. All rights reserved.
//

import Foundation

enum SettingsItemType {
    case onOffSwitch
    case button
    case text
    case slider
}

class SettingsItem {
    var type: SettingsItemType?
    var title = String()
    var detail = String()
    var prefsString = String()
    var defValue : Any?
    var eventHandler: ((_ sender: Any?) -> ())? = nil
    
    init(type: SettingsItemType, title: String, description: String, prefsString: String, eventHandler: ((_ sender: Any?) -> ())?) {
        self.type = type
        self.title = title
        self.detail = description
        self.prefsString = prefsString
        self.eventHandler = eventHandler
    }
    
    init(type: SettingsItemType, title: String, description: String, prefsString: String, defValue: Any?, eventHandler: ((_ sender: Any?) -> ())?) {
        self.type = type
        self.title = title
        self.detail = description
        self.prefsString = prefsString
        self.defValue = defValue
        self.eventHandler = eventHandler
    }
}
