//
//  UIColor.swift
//  echoHackathon
//
//  Created by JEN Lee on 2021/05/21.
//

import Foundation
import UIKit

extension UIColor {
    
    // MARK: hex 변환 가능 init
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    
    // MARK: 색깔들, echo_ 로 시작
    
    class var echo_yellow1: UIColor { UIColor(hex: 0xF5E6AB) }
    class var echo_yellow2: UIColor { UIColor(hex: 0xF2D675) }
    class var echo_yellow3: UIColor { UIColor(hex: 0xF0C33C) }
    class var echo_green1: UIColor { UIColor(hex: 0xB8E6BF) }
    class var echo_green2: UIColor { UIColor(hex: 0x1ED14B) }
    class var echo_green3: UIColor { UIColor(hex: 0x00BA37) }
    class var echo_bg: UIColor { UIColor(hex: 0x1A1A1A) }
    
}


