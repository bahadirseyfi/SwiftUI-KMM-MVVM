//
//  MainViewModel.swift
//  iosApp
//
//  Created by bahadir on 14.04.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation
import Shared

extension MainView {
    final class MainViewModel: ObservableObject {
        
        enum LoadableLaunches {
            case loading
            case result([ChargePoint])
            case error(String)
        }
        let kmmRepository: ChargePointsRepository
        
        init(kmmRepository: ChargePointsRepository) {
            self.kmmRepository = kmmRepository
        }
        
        @Published var points: [ChargePoint] = []
        @Published var launches = LoadableLaunches.loading
        
        func getChargePoints() {
            
            kmmRepository.getChargePoints { points, error in
                if let points {
                    self.points = points
                    print(points)
                } else if let error {
                    //serviceError = error
                }
            }
        }
    }

}
