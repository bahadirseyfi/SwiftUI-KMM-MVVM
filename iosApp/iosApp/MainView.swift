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
    @EnvironmentObject var viewModel: MainViewModel
    
    var body: some View {
        ZStack {
            updateIU()
        }.ignoresSafeArea()
        .onAppear {
            viewModel.getChargePoints()
        }
    }
    
    func updateIU() -> AnyView {
        switch viewModel.launches{
        case .loading:
            return AnyView(Text("Loading"))
            
        case .result(let resultArray):
            return AnyView(viewContent(locations: resultArray))
            
        case .error(let result):
            return AnyView(Text("\(result)"))
        }
    }
    
    private func viewContent(locations: [PoiModel]) -> some View {
        ZStack {
            mapContent(locations: locations)
            VStack {
               // TODO: - Header
                
                Spacer()
                
                stationInfoContent(locations: locations)
            }
           
        }
    }
    
    private func mapContent(locations: [PoiModel]) -> some View {
        Map(coordinateRegion: $viewModel.mapRegion,
            annotationItems: locations,
            annotationContent: { location in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: (location.addressInfo?.latitude).orZero,
                                                             longitude: (location.addressInfo?.longitude).orZero)) {
                MapAnnotationView()
                    .scaleEffect(viewModel.mapLocation.id == location.id ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        viewModel.selectedLocation(location: location)
                    }
            }
        }).preferredColorScheme(.dark)
    }
    
    private func stationInfoContent(locations: [PoiModel]) -> some View {
        ZStack {
            ForEach($viewModel.locations, id: \.id) { location in
                if (viewModel.mapLocation.id).orZero == (location.id) {
                    StationInfoView(location: location,
                                    nextButtonAction: viewModel.nextButtonAction)
                        .shadow(color: Color.black.opacity(0.2), radius: 20)
                        .padding()
                        .transition(.asymmetric(insertion: .move(edge: .trailing),
                                                removal: .move(edge: .leading)))
                        .overlay(alignment: .topTrailing) {
                            Button {
                              //
                            } label: {
                              //
                            }
                        }
                }
            }
        }.animation(.bouncy, value: viewModel.mapLocation.id)
    }
}
