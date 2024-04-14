//
//  MainView.swift
//  iosApp
//
//  Created by bahadir on 14.04.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @ObservedObject private(set) var viewModel: MainViewModel
    
    var body: some View {
        VStack {
            ForEach(viewModel.points, id: \.id) { item in
                Text(item.uuid ?? "")
            }
        }.onAppear {
            viewModel.getChargePoints()
        }
    }
}
