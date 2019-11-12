//
//  Utils.swift
//  SBohemNaCestach
//
//  Created by Petr Hracek on 12/11/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import Foundation
import UIKit

func get_cgfloat(size: String) -> CGFloat {
    guard let n = NumberFormatter().number(from: size) else { return 0 }
    let f = CGFloat(truncating: n)
    return f
}
