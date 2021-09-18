//
//  UIKit+DesignColor.swift
//  Cars
//
//  Created by Joce on 14.09.2021.
//

import UIKit

public extension UIColor {
    static func design(_ style: DesignColor) -> UIColor {
        switch style {
        case let .background(style):
            return UIColor(named: style.description)!
        case let .constant(style):
            return UIColor(named: style.description)!
        case let .text(style):
            return UIColor(named: style.description)!
        }
    }
}
