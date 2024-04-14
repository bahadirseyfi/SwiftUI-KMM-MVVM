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
    @State private var viewModel: MainViewModel
    
    init(kmmRepository: ChargePointsRepository) {
        self.viewModel = MainViewModel(kmmRepository: kmmRepository)
    }
    
    var body: some View {
        ZStack {
            switch viewModel.launches {
            case .loading:
                // TODO: - Handle loading stat
                Text("Loading")
                
            case .result(let resultArray):
                viewContent(locations: resultArray)
                
            case .error(let result):
                // TODO: - Handle Error stat
                Text("\(result)")
            }
        }
        .background(ignoresSafeAreaEdges: .top)
        .onAppear {
            viewModel.performInitialFetch()
        }
    }

    private func viewContent(locations: [PoiModel]) -> some View {
        ZStack {
            mapContent(locations: locations)
            VStack {
               // TODO: - Header
                
                Spacer()
                
                stationInfoContent(locations: locations)
                    .padding(.bottom)
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
            ForEach(viewModel.locations, id: \.id) { location in
                if (viewModel.mapLocation.id).orZero == (location.id) {
                    StationInfoView(location: location,
                                    nextButtonAction: viewModel.nextButtonAction)
                        .shadow(color: Color.black.opacity(0.2), radius: 20)
                        .padding()
                        .transition(.asymmetric(insertion: .move(edge: .trailing),
                                                removal: .move(edge: .leading)))
                        .overlay(alignment: .topTrailing) {
                            Button {
                                viewModel.addFavoriteButonAction(location: location)
                            } label: {
                                Image(systemName: viewModel.isAddedFavorite ? E.Strings.Images.heartFill : E.Strings.Images.heart)
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.red)
                                    .padding([.trailing, .top], 24)
                            }
                        }
                }
            }
        }.animation(.bouncy, value: viewModel.mapLocation.id)
    }
}
