//
//  PrayerView.swift
//  SBohemNaCestach
//
//  Created by Petr Hracek on 04/11/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import Foundation
import UIKit

class PrayerView: UIView {
    
    let prayerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        addSubview(prayerLabel)
        let margin = readableContentGuide
        NSLayoutConstraint.activate([
            prayerLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            prayerLabel.topAnchor.constraint(equalTo: margin.topAnchor),
            prayerLabel.bottomAnchor.constraint(equalTo: margin.bottomAnchor),
            prayerLabel.trailingAnchor.constraint(equalTo: margin.trailingAnchor)])
    }
}
