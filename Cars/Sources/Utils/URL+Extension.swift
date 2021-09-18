//
//  URL+Extension.swift
//  Cars
//
//  Created by Joce on 18.09.2021.
//

import Foundation

public extension URL {
    init?(string: String?) {
        guard let string = string else {
            return nil
        }
        self.init(string: string)
    }
}
