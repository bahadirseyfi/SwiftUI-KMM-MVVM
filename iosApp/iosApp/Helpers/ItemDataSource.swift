//
//  ItemDataSource.swift
//  iosApp
//
//  Created by bahadir on 14.04.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftData
import SwiftUI

final class ItemDataSource {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    @MainActor
    static let shared = ItemDataSource()

    @MainActor
    private init() {
        self.modelContainer = try! ModelContainer(for: LocationData.self)
        self.modelContext = modelContainer.mainContext
    }

    func appendItem(item: LocationData) {
        modelContext.insert(item)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func fetchItems() -> [LocationData] {
        do {
            return try modelContext.fetch(FetchDescriptor<LocationData>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func removeItem(_ item: LocationData) {
        modelContext.delete(item)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
