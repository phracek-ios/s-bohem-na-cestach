//
//  Colors.swift
//  SBohemNaCestach
//
//  Created by Petr Hracek on 25/10/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import Foundation
import UIKit
import DynamicColor

extension UIColor {
    struct WithGodOnRoad {
        
        static func mainColor() -> UIColor {
            return UIColor(hexString: "#E0F2FE")
        }
        
        static func titleColor() -> UIColor {
            return UIColor(hexString: "#0096FB")
        }
        static func blueColor() -> UIColor {
            return UIColor(hexString: "#E0F2FE")
        }
        
        static func backLightColor() -> UIColor {
            return UIColor.white
        }
        
        static func textNightColor() -> UIColor {
            return UIColor.white
        }
        
    }
}
