//
//  MainViewModel.swift
//  iosApp
//
//  Created by bahadir on 14.04.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation
import Shared
import MapKit

final class MainViewModel: ObservableObject {
    
    enum LoadableLaunches {
        case loading
        case result([PoiModel])
        case error(String)
    }
    
    let kmmRepository: ChargePointsRepository
    
    private let defaultLocation: PoiModel = {
        return PoiModel(id: nil,
                        uuid: nil,
                        usageCost: nil,
                        operatorInfo: nil,
                        addressInfo: nil)
    }()
    
    @Published var mapLocation: PoiModel {
        didSet {
            self.updateMapRegion(poi: mapLocation)
        }
    }
    
    init(kmmRepository: ChargePointsRepository) {
        self.kmmRepository = kmmRepository
        mapLocation = defaultLocation
    }
    
    @Published var launches = LoadableLaunches.loading
    
    // MARK: - Map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1,
                                   longitudeDelta: 0.1)
    
    // All loaded locations
    @Published var locations: [PoiModel] = []
 // @Published var locationsData: [LocationData] = []
    @Published var idLocation: [Int] = []
    
    private func updateMapRegion(poi: PoiModel) {
        mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: (poi.addressInfo?.latitude).orZero,
                                                                      longitude: (poi.addressInfo?.longitude).orZero),
                                           span: mapSpan)
    }
    
    func selectedLocation(location: PoiModel) {
            mapLocation = location
    }
    
    func nextButtonAction() {
        guard let currentIndex = locations.firstIndex(where: {$0.id == mapLocation.id }) else  { return }
        
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            guard let firstLocation = locations.first  else {return}
            selectedLocation(location: firstLocation)
            return
        }
        
        let nextLocation = locations[nextIndex]
        selectedLocation(location: nextLocation)
    }
    
    
    // MARK: - Network logic
    func getChargePoints() {
        kmmRepository.getChargePoints { points, error in
            if let points {
                print("Points: ",points)
                print("Mapped: ", Mapper.map(from: points))
                self.launches = .result(Mapper.map(from: points))
                
            } else if let error {
                self.launches = .error(error.localizedDescription)
            }
        }
    }
}
