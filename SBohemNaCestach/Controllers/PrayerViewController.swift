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

    @IBOutlet weak var prayerLabel: UILabel!

    // MARK: View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = prayerTitle
        prayerLabel.attributedText = generateContent(text: prayer)

   }
}
