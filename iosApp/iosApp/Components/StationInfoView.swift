//
//  StationInfoView.swift
//  iosApp
//
//  Created by bahadir on 14.04.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct StationInfoView: View {
    @Binding var location: PoiModel
    var nextButtonAction: ()->()
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                imageSetion
                titleSection
            }
            
            VStack(alignment: .leading, spacing: 8) {
                learnMoreButton
                nextButton
            }
        }
            .padding(20)
            .background (
                RoundedRectangle(cornerRadius: 10)
                    .fill(.ultraThinMaterial)
                    .offset(y: 65)
            )
            .cornerRadius(10)
        }
}

extension StationInfoView {
    private var imageSetion: some View {
        ZStack {
            Image("charge-icon")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .cornerRadius(10)
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text((location.operatorInfo?.title).orEmptyString)
                .font(.title2)
            Text((location.addressInfo?.title).orEmptyString)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var learnMoreButton: some View {
        Button {
         // TODO: - learn more
        } label: {
            Text("Learn More")
                .font(.headline)
                .frame(width: 130, height: 35)
        }
        .buttonStyle(.borderedProminent)
    }
    
    private var nextButton: some View {
        Button {
           nextButtonAction()
        } label: {
            Text("Next")
                .font(.headline)
                .frame(width: 130, height: 35)
        }
        .buttonStyle(.bordered)
    }
}
