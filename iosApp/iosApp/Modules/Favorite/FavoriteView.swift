//
//  FavoriteView.swift
//  iosApp
//
//  Created by bahadir on 14.04.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct FavoriteView: View {
    @State var viewModel: FavoriteViewModel
    
    init() {
        self.viewModel = FavoriteViewModel()
    }
    
    var body: some View {
        NavigationView {
            if !viewModel.items.isEmpty {
                listContent
            } else {
                Text("No data, add favorite locations!")
            }
        }
        .onAppear { viewModel.fetchItems() }
        .onReceive(viewModel.locationDataPublisher,
                   perform: viewModel.updateItems)
    }
    
    private var listContent: some View {
        List {
            ForEach(viewModel.items, id: \.self) { item in
                HStack(alignment: .center, spacing: 8) {
                    Text(item.operatorInfo.title)
                    
                    Text(item.addressInfo.country.title)
                    
                    Spacer()
                    
                    Button {
                        // TODO: - Open website from URL
                    } label: {
                        Image(systemName: E.Strings.Images.globe)
                    }
                }
            }.onDelete(perform: viewModel.deleteItem)
        }
    }
}
