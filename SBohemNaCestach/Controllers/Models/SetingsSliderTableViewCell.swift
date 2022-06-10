//
//  SetingsSliderTableViewCell.swift
//  SBohemNaCestach
//
//  Created by Petr Hracek on 09.06.2022.
//  Copyright © 2022 Petr Hracek. All rights reserved.
//

import Foundation
import UIKit

class SettingsSliderTableViewCell: UITableViewCell {

    static let cellId = "settingsSliderItem"
    let keys = SettingsBundleHelper.SettingsBundleKeys.self
    
    var title: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 18)
        l.backgroundColor = .clear
        l.sizeToFit()
        l.numberOfLines = 0
        l.isUserInteractionEnabled = true
        return l
    }()
    
    var detail: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14)
        l.numberOfLines = 0
        l.isUserInteractionEnabled = true
        l.textAlignment = .left
        l.translatesAutoresizingMaskIntoConstraints = false
        l.lineBreakMode = .byWordWrapping
        l.sizeToFit()
        l.contentMode = .scaleAspectFit
        return l
    }()
    
    lazy var itemSlider: UISlider = {
        let i = UISlider()
        i.frame = CGRect(x:0, y:0, width: 100, height: 20)
        return i
    }()
    
    var delegate: SettingsDelegate?
    let userDefaults = UserDefaults.standard
    var settingsItem: SettingsItem?
    var backColor = UIColor.WithGodOnRoad.backLightColor()
    var labelColor = UIColor.WithGodOnRoad.textLightColor()

    
    var fontSize: CGFloat = 14
    func configureCell(settingsItem: SettingsItem, delegate: SettingsDelegate, cellWidth: CGFloat) {
        self.settingsItem = settingsItem
        //self.delegate = delegate
//        self.textLabel?.text = settingsItem.title
//        self.detailTextLabel?.text = settingsItem.detail
        addSubview(title)
        addSubview(detail)
        self.accessoryView = itemSlider
        if UserDefaults.standard.object(forKey: settingsItem.prefsString) != nil {
            fontSize = CGFloat(UserDefaults.standard.integer(forKey: settingsItem.prefsString))
        }
        title.text = settingsItem.title
        detail.attributedText = generateContent(text: settingsItem.detail, size: fontSize, color: UIColor.WithGodOnRoad.textLightColor())
        let darkMode = userDefaults.bool(forKey: keys.night)
        if darkMode {
            self.labelColor = UIColor.WithGodOnRoad.textNightColor()
            self.backColor = UIColor.WithGodOnRoad.backNightColor()
        }
        else {
            self.labelColor = UIColor.WithGodOnRoad.textLightColor()
            self.backColor = UIColor.WithGodOnRoad.backLightColor()
        }
        title.textColor = self.labelColor
        detail.textColor = self.labelColor
        self.backgroundColor = self.backColor
        title.backgroundColor = self.backColor
        title.textColor = self.labelColor
        detail.backgroundColor = self.backColor
        detail.textColor = self.labelColor
        
        itemSlider.minimumValue = 14
        itemSlider.maximumValue = 30
        
        print(itemSlider.frame.width)
        print(cellWidth)
        let titleWidth = cellWidth - itemSlider.frame.width - 12 - 15 - 12
        let detailWidth = cellWidth - itemSlider.frame.width - 12 - 20
        addConstraintsWithFormat(format: "H:|-12-[v0(\(titleWidth))]", views: title)
        addConstraintsWithFormat(format: "H:|-12-[v0(\(detailWidth))]", views: detail)
        addConstraintsWithFormat(format: "V:|-20-[v0]-10-[v1]", views: title, detail)

//        detail.widthAnchor.constraint(equalTo: title.widthAnchor ).isActive = true
        itemSlider.setValue(Float(fontSize), animated: true)
        itemSlider.addTarget(self, action: #selector(self.sliderValueChanged(_:)), for: .valueChanged)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @objc func sliderValueChanged(_ sender: UISlider!) {
        print("Slider value \(Int(sender.value))")
        UserDefaults.standard.set(Int(sender.value),  forKey: settingsItem!.prefsString)
        detail.attributedText = generateContent(text: settingsItem!.detail, size: get_cgfloat(size: "\(Int(sender.value))"), color: self.labelColor)
        detail.sizeToFit()
    }

}
