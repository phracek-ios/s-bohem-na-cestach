//
//  PrayersTableViewCell.swift
//  SBohemNaCestach
//
//  Created by Petr Hracek on 25/10/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import UIKit

class PrayersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var prayerName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
