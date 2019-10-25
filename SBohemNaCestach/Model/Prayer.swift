//
//  Prayer.swift
//  SBohemNaCestach
//
//  Created by Petr Hracek on 18/10/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import Foundation

struct Prayer: Decodable {
    var id: Int
    var name: String
    var prayer: String
}
