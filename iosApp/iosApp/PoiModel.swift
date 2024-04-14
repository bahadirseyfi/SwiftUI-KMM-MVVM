//
//  PoiModel.swift
//  iosApp
//
//  Created by bahadir on 14.04.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation

// MARK: - PoiModel
struct PoiModel: Codable, Identifiable {
    let id: Int?
    let uuid, usageCost: String?
    let operatorInfo: OperatorInfo?
    let addressInfo: AddressInfo?
}

struct OperatorInfo: Codable {
    let title: String?
    let websiteURL: String?
}

struct AddressInfo: Codable {
    let title: String?
    let addressLine1: String?
    let stateOrProvince: String?
    let country: Country?
    let latitude: Double?
    let longitude: Double?
}

struct Country: Codable {
    let title: String?
}
