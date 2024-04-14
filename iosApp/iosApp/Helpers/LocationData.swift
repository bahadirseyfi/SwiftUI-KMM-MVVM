//
//  LocationData.swift
//  iosApp
//
//  Created by bahadir on 14.04.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation
import SwiftData

@Model
final class LocationData: Identifiable {
    var id: Int
    var usageCost: String
    var operatorInfo: OperatorInfoData
    var addressInfo: AddressInfoData
    
    init(id: Int, usageCost: String, operatorInfo: OperatorInfoData, addressInfo: AddressInfoData) {
        self.id = id
        self.usageCost = usageCost
        self.operatorInfo = operatorInfo
        self.addressInfo = addressInfo
    }
}

@Model
class OperatorInfoData {
    var title: String
    var websiteURL: String
    
    init(title: String, websiteURL: String) {
        self.title = title
        self.websiteURL = websiteURL
    }
}

@Model
class AddressInfoData {
    var title: String
    var addressLine1: String
    var stateOrProvince: String
    var country: CountryData
    var latitude: Double
    var longitude: Double
    
    init(title: String, addressLine1: String, stateOrProvince: String, country: CountryData, latitude: Double, longitude: Double) {
        self.title = title
        self.addressLine1 = addressLine1
        self.stateOrProvince = stateOrProvince
        self.country = country
        self.latitude = latitude
        self.longitude = longitude
    }
}

@Model
class CountryData {
    var title: String
    
    init(title: String) {
        self.title = title
    }
}

@Model
class ConnectionData {
    var levelID: Int
    var voltage: Int
    var powerKW: Int
    
    init(levelID: Int, voltage: Int, powerKW: Int) {
        self.levelID = levelID
        self.voltage = voltage
        self.powerKW = powerKW
    }
}
