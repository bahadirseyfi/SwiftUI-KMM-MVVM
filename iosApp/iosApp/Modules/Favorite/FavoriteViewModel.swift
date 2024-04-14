//
//  FavoriteViewModel.swift
//  iosApp
//
//  Created by bahadir on 15.04.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import Combine
import SwiftData

@Observable
final class FavoriteViewModel {
    
    let locationDataPublisher = PassthroughSubject<[LocationData], Never>()
    
    var items: [LocationData] = []
    
    @ObservationIgnored
    let dataSource: ItemDataSource
    
    init(dataSource: ItemDataSource = ItemDataSource.shared) {
        self.dataSource = dataSource
    }
    
    
    // MARK: - SwiftData logics
    func deleteItem(at offsets: IndexSet) {
        offsets.forEach { dataSource.removeItem(items[$0]) }
        items.remove(atOffsets: offsets)
    }
    
    func fetchItems() {
        let items = dataSource.fetchItems()
        locationDataPublisher.send(items)
    }
    
    func updateItems(_ fetchedItems: [LocationData]) {
        self.items = fetchedItems
    }
}
