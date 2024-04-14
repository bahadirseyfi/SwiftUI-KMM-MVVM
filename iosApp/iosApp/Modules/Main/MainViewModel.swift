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
import Combine

final class MainViewModel: ObservableObject {
    
    enum LoadableLaunches {
        case loading
        case result([PoiModel])
        case error(String)
    }
    
    let kmmRepository: ChargePointsRepository
    
    @Published var mapLocation: PoiModel
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(kmmRepository: ChargePointsRepository) {
        self.kmmRepository = kmmRepository
        let location = defaultLocation
        self.mapLocation = location
        
        $mapLocation
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.updateMapRegion(poi: self.mapLocation )
            }
            .store(in: &cancellables)
    }
    
    @Published var launches = LoadableLaunches.loading
    
    // MARK: - Map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1,
                                   longitudeDelta: 0.1)
    
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
                self.locations = Mapper.map(from: points)
                self.launches = .result(Mapper.map(from: points))
                if let mapLocation = self.locations.first {
                    self.mapLocation = mapLocation
                }
            } else if let error {
                self.launches = .error(error.localizedDescription)
            }
        }
    }
    
    private let defaultLocation: PoiModel = {
        return PoiModel(id: nil,
                        uuid: nil,
                        usageCost: nil,
                        operatorInfo: nil,
                        addressInfo: AddressInfo(title: nil,
                                                 addressLine1: nil,
                                                 stateOrProvince: nil,
                                                 country: nil,
                                                 latitude: 40.450356638230915,
                                                 longitude: -3.677850810659322))
    }()
}
