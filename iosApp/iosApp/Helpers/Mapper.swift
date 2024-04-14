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
    
    static func map(from poiModel: PoiModel) -> LocationData {
        let operatorInfo = OperatorInfo(title: poiModel.operatorInfo?.title.orEmptyString,
                                        websiteURL: poiModel.operatorInfo?.websiteURL.orEmptyString)
        
        let country: Country? = poiModel.addressInfo != nil ? Country(title: poiModel.addressInfo!.country?.title.orEmptyString) : nil
        
        let addressInfo = AddressInfo(title: (poiModel.addressInfo?.title).orEmptyString,
                                      addressLine1: (poiModel.addressInfo?.addressLine1).orEmptyString,
                                      stateOrProvince: (poiModel.addressInfo?.stateOrProvince).orEmptyString,
                                      country: country,
                                      latitude: (poiModel.addressInfo?.latitude).orZero,
                                      longitude: (poiModel.addressInfo?.longitude).orZero)
        
        return LocationData(id: poiModel.id.orZero,
                            usageCost: poiModel.usageCost.orEmptyString,
                            operatorInfo: OperatorInfoData(title: operatorInfo.title.orEmptyString,
                                                           websiteURL: operatorInfo.websiteURL.orEmptyString),
                            addressInfo: AddressInfoData(title: addressInfo.title .orEmptyString,
                                                         addressLine1: addressInfo.addressLine1.orEmptyString,
                                                         stateOrProvince: addressInfo.stateOrProvince.orEmptyString,
                                                         country: CountryData(title: (addressInfo.country?.title).orEmptyString),
                                                         latitude: addressInfo.latitude.orZero,
                                                         longitude: addressInfo.longitude.orZero))
    }
}
