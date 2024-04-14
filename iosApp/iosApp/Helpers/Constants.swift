//
//  Constants.swift
//  iosApp
//
//  Created by bahadir on 14.04.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation

enum E {
    enum Strings {
        enum Title {
            static let locations = "Locations"
            static let widgetName = "Jedlix Widget"
        }

        enum Errors {
            static let error = "Error!"
            static let statusCode = "Unexpected Status Code"
            static let decoding = "Decoding Error"
            static let failedDecoding = "Failed to decode object"
            
            static let noCell = "Couldn't find cell for: "
            static let noItems = "No Items"
        }
        
        enum Text {
            static let ok = "OK"
            static let cancel = "Cancel"
            static let favoriteStat = "Favorite Stations"
        }
        
        enum Images {
            static let arrow = "arrow.down"
            static let heartFill = "heart.fill"
            static let heart = "heart"
            static let chargeIcon = "charge-icon"
        }
        
        enum Description {
            static let descriptionWidget = "This is an case app widget for jedlix."
        }
    }
}
