//
//  Mapper.swift
//  iosApp
//
//  Created by bahadir on 14.04.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation
import Shared

final class Mapper {
    static func map(from kmmChargePoint: [ChargePoint]) -> [PoiModel] {
        return kmmChargePoint.map { kmmChargePoint in
            let operatorInfo = OperatorInfo(
                title: kmmChargePoint.operatorInfo?.title,
                websiteURL: kmmChargePoint.operatorInfo?.websiteURL
            )
            
            let addressInfo = AddressInfo(
                title: kmmChargePoint.addressInfo?.title,
                addressLine1: kmmChargePoint.addressInfo?.addressLine1,
                stateOrProvince: kmmChargePoint.addressInfo?.stateOrProvince,
                country: Country(title: kmmChargePoint.addressInfo?.country?.title),
                latitude: Double(truncating: kmmChargePoint.addressInfo?.latitude ?? 0),
                longitude: Double(truncating: kmmChargePoint.addressInfo?.longitude ?? 0)
            )
            
            return PoiModel(
                id: Int(truncating: kmmChargePoint.id ?? 0),
                uuid: kmmChargePoint.uuid,
                usageCost: kmmChargePoint.usageCost,
                operatorInfo: operatorInfo,
                addressInfo: addressInfo
            )
        }
    }
}
