//
//  Array+Extension.swift
//  Cars
//
//  Created by Joce on 16.09.2021.
//

extension Array where Element == String {
    var commaSeparated: String {
        joined(separator: ", ")
    }
}
