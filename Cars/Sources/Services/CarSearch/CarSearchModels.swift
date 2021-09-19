//
//  CarSearchModels.swift
//  Cars
//
//  Created by Joce on 18.09.2021.
//

enum CarSearch {
    struct Request {}

    struct Response {
        let items: [Item]
    }
}

extension CarSearch.Response {
    enum Item {
        case car(data: Car)
        case highlightedCar(data: Car)
        case brand(data: Brand)
    }

    struct Car {
        let id: Int
        let title: String
        let year: String
        let imageUrl: String?
        let horsePowers: Int
        let brand: String
        let price: Int
        let engineVolume: Double
        let mileage: Int
        let daysPosted: Int
    }

    struct Brand {
        let id: Int
        let title: String
        let country: String
        let rating: String
        let imageUrl: String?
        let year: String
    }
}

extension CarSearch.Response.Brand: Decodable {}
extension CarSearch.Response.Car: Decodable {}

extension CarSearch.Response.Item: Decodable {
    private enum `Type`: String, Decodable {
        case car = "Car"
        case brand = "Brand"
        case highlightedCar = "HighlightedCar"
    }

    private enum CodingKeys: String, CodingKey {
        case type
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(Type.self, forKey: .type)
        switch type {
        case .car:
            self = try .car(data: CarSearch.Response.Car(from: decoder))
        case .highlightedCar:
            self = try .highlightedCar(data: CarSearch.Response.Car(from: decoder))
        case .brand:
            self = try .brand(data: CarSearch.Response.Brand(from: decoder))
        }
    }
}

extension CarSearch.Response: Decodable {}
