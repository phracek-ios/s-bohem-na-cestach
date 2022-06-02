//
//  PrayersTableViewCell.swift
//  SBohemNaCestach
//
//  Created by Petr Hracek on 25/10/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import UIKit

class PrayersTableViewCell: UITableViewCell {
    
    static let cellId = "PrayersTableViewCell"
    
    lazy var prayerName: UILabel = {
      let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.setupUI()
    }
    
    func setupUI() {
        let userDefaults = UserDefaults.standard
        contentView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        stackView.addSubview(prayerName)
        prayerName.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        prayerName.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        prayerName.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        prayerName.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        prayerName.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }
    func configureCell(name: String) {
        prayerName.text = name
        
    }
}
