//
//  MapAnnotationView.swift
//  iosApp
//
//  Created by bahadir on 14.04.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct MapAnnotationView: View {
    let accentColor = Color.red
    var body: some View {
        VStack {
            Image(systemName: "map.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .font(.headline)
                .foregroundColor(.white)
                .padding(6)
                .background(accentColor)
                .cornerRadius(36)
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(accentColor)
                .frame(width: 10, height: 10)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -9)
                .padding(.bottom, 40)
        }
    }
}
