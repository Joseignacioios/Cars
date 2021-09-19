//
//  CarDetailModels.swift
//  Cars
//
//  Created by Joce on 19.09.2021.
//

enum CarDetail {
    struct Input {
        let car: CarSearch.Response.Car
        let isHighlighted: Bool
    }

    struct Data {
        let car: CarSearch.Response.Car
        let isHighlighted: Bool
    }

    struct ViewModel {
        let car: CarViewModel
    }
}
