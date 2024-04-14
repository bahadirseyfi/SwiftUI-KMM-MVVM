//
//  StationListView.swift
//  iosApp
//
//  Created by bahadir on 15.04.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct StationListView: View {
    
    let locations: [PoiModel]
    var nextButtonAction: (PoiModel) -> Void
    
    var body: some View {
        List {
            ForEach(locations) { location in
                listRowView(location: location)
                    .onTapGesture {
                        nextButtonAction(location)
                    }
                    .listRowBackground(Color.clear)
            }
        }
        .listStyle(PlainListStyle())
    }
}

extension StationListView {
    private func listRowView(location: PoiModel) -> some View {
        HStack {
            Image(E.Strings.Images.chargeIcon)
                .resizable()
                .scaledToFill()
                .frame(width: 45, height: 45)
                .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text((location.operatorInfo?.title).orEmptyString)
                    .font(.headline)
                Text((location.addressInfo?.stateOrProvince).orEmptyString)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}


