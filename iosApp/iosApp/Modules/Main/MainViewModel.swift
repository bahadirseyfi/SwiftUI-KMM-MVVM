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
import SwiftUI

@Observable
final class MainViewModel {
    @ObservationIgnored
    private let dataSource: ItemDataSource
    
    enum LoadableLaunches {
        case loading
        case result([PoiModel])
        case error(String)
    }
    
    let kmmRepository: ChargePointsRepository

    private var cancellables: Set<AnyCancellable> = []
    
    init(kmmRepository: ChargePointsRepository,
         dataSource: ItemDataSource = ItemDataSource.shared) {
        self.kmmRepository = kmmRepository
        let location = defaultLocation
        self.mapLocation = location
        self.dataSource = dataSource
    }
    
    // MARK: - Favorite Flag
    var isAddedFavorite: Bool = false
    var launches = LoadableLaunches.loading
    var hasAppeared: Bool = false
    var showLocationList: Bool = false
    
    // MARK: - Map
    var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    
    @ObservationIgnored
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1,
                                   longitudeDelta: 0.1)
    
    var locations: [PoiModel] = []
    var locationsData: [LocationData] = []
    
    var mapLocation: PoiModel {
        didSet {
            self.updateMapRegion(poi: mapLocation)
        }
    }
    
    private func updateMapRegion(poi: PoiModel) {
        mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: (poi.addressInfo?.latitude).orZero,
                                                                      longitude: (poi.addressInfo?.longitude).orZero),
                                       span: mapSpan)
    }
    
    func selectedLocation(location: PoiModel) {
        mapLocation = location
    }
    
    
    // MARK: - Actions
    func nextButtonAction() {
        guard let currentIndex = locations.firstIndex(where: {$0.id == mapLocation.id }) else  { return }
        
        let nextIndex = currentIndex + 1
        let nextLocation: PoiModel
        
        if locations.count - 1 >= nextIndex {
            nextLocation = locations[nextIndex]
        } else {
            guard let firstLocation = locations.first  else { return }
            nextLocation = firstLocation
        }
        
        selectedLocation(location: nextLocation)
        checkFavorite(location: nextLocation)
    }
    
    func addFavoriteButonAction(location: PoiModel) {
        if isAddedFavorite, let locationData = locationsData.first(where: { $0.id == location.id }) {
            dataSource.removeItem(locationData)
        } else {
            dataSource.appendItem(item: Mapper.map(from: location))
        }
    
        locationsData = dataSource.fetchItems()
        checkFavorite(location: location)
    }

    func checkFavorite(location: PoiModel) {
        isAddedFavorite = locationsData.contains(where: { $0.id == location.id })
    }
    
    
    // MARK: - Network & Local Storage logic
    func getChargePoints() {
        guard !hasAppeared else { return }
        
        kmmRepository.getChargePoints { [weak self] points, error in
            guard let self else { return }
            
            if let points {
                DispatchQueue.main.async {
                    self.locations = Mapper.map(from: points)
                    self.launches = .result(Mapper.map(from: points))
                    if let mapLocation = self.locations.first {
                        self.mapLocation = mapLocation
                        self.checkFavorite(location: mapLocation)
                    }
                }
            } else if let error {
                launches = .error(error.localizedDescription)
            }
        }
    }
    
    func getLocationsData() {
        let locations = dataSource.fetchItems()
        self.locationsData = locations
        checkFavorite(location: mapLocation)
    }
    
    // MARK: - Constants
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

// MARK: - View Model on appear functions
extension MainViewModel {
    @MainActor
    func performInitialFetch() {
        getChargePoints()
        getLocationsData()
        hasAppeared = true
    }
}
