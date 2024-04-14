//
//  MainView.swift
//  iosApp
//
//  Created by bahadir on 14.04.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import Shared
import MapKit

struct MainView: View {
    @ObservedObject private(set) var viewModel: MainViewModel
    
    var body: some View {
        VStack {
            updateIU()
        }
        .onAppear {
            viewModel.getChargePoints()
        }
    }
    
    func updateIU() -> AnyView {
        switch viewModel.launches{
        case .loading:
            return AnyView(Text("Loading"))
            
        case .result(let resultArray):
            return AnyView(mapContent(locations: resultArray))
            
        case .error(let result):
            return AnyView(Text("\(result)"))
        }
    }
    
    private func mapContent(locations: [PoiModel]) -> some View {
        ZStack {
            Map(coordinateRegion: $viewModel.mapRegion,
                annotationItems: viewModel.locations,
                annotationContent: { location in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: (location.addressInfo?.latitude).orZero,
                                                                 longitude: (location.addressInfo?.longitude).orZero)) {

                }
            }).preferredColorScheme(.dark)
        }
    }
}
