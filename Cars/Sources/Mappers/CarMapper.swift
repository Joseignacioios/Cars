//
//  CarMapper.swift
//  Cars
//
//  Created by Joce on 19.09.2021.
//

import Foundation

protocol CarMapperProtocol {
    func map(car: CarSearch.Response.Car, isHighlighted: Bool) -> CarViewModel
}

struct CarMapper: CarMapperProtocol {
    private let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter
    }()

    private let measurementFormatter: MeasurementFormatter = {
        let measurementFormatter = MeasurementFormatter()

        return measurementFormatter
    }()

    private func pretify(squareMetres: Double) -> String {
        let measurement = Measurement(value: squareMetres, unit: UnitArea.squareMeters)
        return measurementFormatter.string(from: measurement)
    }

    private func pretify(days: Int) -> String {
        let formatString: String = NSLocalizedString("REMAINING_DAY_PATTERN", comment: "")
        let resultString = String.localizedStringWithFormat(formatString, days)
        return resultString
    }

    private func pretify(double: Double) -> String {
        let number = NSNumber(value: double)
        return numberFormatter.string(from: number) ?? "\(double)"
    }
    
    func map(car: CarSearch.Response.Car, isHighlighted: Bool) -> CarViewModel {
        CarViewModel(
            id: car.id,
            title: car.title,
            imageUrl: URL(string: car.imageUrl ?? ""),
            isPremium: isHighlighted,
            horsePowers: String(format: NSLocalizedString("CAR_LIST_HORSEPOWERS", comment: ""), "\(car.horsePowers)"),
            brand: car.brand,
            price: String(format: NSLocalizedString("CAR_LIST_PRICE", comment: ""), "\(car.price)"),
            engineVolume: String(format: NSLocalizedString("CAR_LIST_ENGINEVOLUME", comment: ""), "\(pretify(double:car.engineVolume))"),
            mileage: String(format: NSLocalizedString("CAR_LIST_MILEAGE", comment: ""), "\(car.mileage)"),
            year: car.year,
            daysPosted: pretify(days: car.daysPosted)
        )
    }
}
