//
//  FavoriteView.swift
//  iosApp
//
//  Created by bahadir on 14.04.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import Combine
import SwiftData

final class LocationDataManager {
    let locationDataPublisher = PassthroughSubject<[LocationData], Never>()
}

struct FavoriteView: View {
    private let dataSource: ItemDataSource
    @State var items: [LocationData] = []
    private let locationDataManager = LocationDataManager()
    
    init(dataSource: ItemDataSource = ItemDataSource.shared) {
        self.dataSource = dataSource
        items = dataSource.fetchItems()
    }
    
    var body: some View {
        NavigationView {
            if !items.isEmpty {
                listContent
            } else {
                Text("No data, add favorite locations!")
            }
        }
        .onAppear { fetchItems() }
        .onReceive(locationDataManager.locationDataPublisher, perform: updateItems)
    }
    
    private var listContent: some View {
        List {
            ForEach(items, id: \.self) { item in
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
            }.onDelete(perform: deleteItem)
        }
    }
    
    func deleteItem(at offsets: IndexSet) {
        offsets.forEach { dataSource.removeItem(items[$0]) }
        items.remove(atOffsets: offsets)
    }
    
    func fetchItems() {
        let items = dataSource.fetchItems()
        locationDataManager.locationDataPublisher.send(items)
    }
    
    func updateItems(_ fetchedItems: [LocationData]) {
        self.items = fetchedItems
    }
}
