//
//  DesignColorsUnitTests.swift
//  CarsUnitTests
//
//  Created by Joce on 14.09.2021.
//

@testable import Cars
import UIKit
import XCTest

class DesignColorsUnitTests: XCTestCase {
    func testBackgroundColorsNullability() throws {
        DesignColor.Background.allCases.forEach { style in
            let color = UIColor(named: style.description)
            XCTAssertNotNil(color, "Background style \(style) should not be nil")
        }
    }

    func testConstantsColorsNullability() throws {
        DesignColor.Constant.allCases.forEach { style in
            let color = UIColor(named: style.description)
            XCTAssertNotNil(color, "Constant style \(style) should not be nil")
        }
    }

    func testTextColorsNullability() throws {
        DesignColor.Text.allCases.forEach { style in
            let color = UIColor(named: style.description)
            XCTAssertNotNil(color, "Constant style \(style) should not be nil")
        }
    }
}
