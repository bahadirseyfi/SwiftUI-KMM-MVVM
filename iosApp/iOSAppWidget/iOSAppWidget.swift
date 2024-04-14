//
//  iOSAppWidget.swift
//  iOSAppWidget
//
//  Created by bahadir on 14.04.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import WidgetKit
import SwiftUI

struct SimpleItem {
    var id: String
    var text: String
    var operatorTitle: String
}

struct Provider: TimelineProvider {
    
    private let dataSource: ItemDataSource
    
    init(dataSource: ItemDataSource = ItemDataSource.shared) {
        self.dataSource = dataSource
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        let mockData = SimpleItem(id: "1", text: "15€ per hour", operatorTitle: "Tesla Charge")
        
        return SimpleEntry(date: Date(), items: [mockData])
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), items: [])
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task { @MainActor in
            var entries: [SimpleEntry] = []

            let dataItems = ItemDataSource.shared.fetchItems()
            let simpleItems = dataItems.map { SimpleItem(id: $0.id.entityIdentifierString,
                                                         text: $0.operatorInfo.title,
                                                         operatorTitle: $0.usageCost) }
            
            entries.append(SimpleEntry(date: .now, items: simpleItems))

            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let items: [SimpleItem]
}

struct iOSAppWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack {
            if entry.items.isEmpty {
                Text(E.Strings.Errors.noItems)
                    .foregroundStyle(.white)
                    .font(.title)
                    .lineLimit(1)
            } else {
                HStack {
                    Text(E.Strings.Text.favoriteStat)
                        .foregroundStyle(.white)
                        .font(.callout)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Image(E.Strings.Images.chargeIcon)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .aspectRatio(contentMode: .fit)
                }
                
                Spacer()
                
                itemsContent()
            }
        }
    }
    
    fileprivate func itemsContent() -> VStack<ForEach<[SimpleItem], String, some View>> {
        return VStack {
            ForEach(entry.items, id: \.id) { item in
                HStack(spacing: 3) {
                    Text(item.operatorTitle)
                        .foregroundStyle(.orange)
                        .lineLimit(1)
                        .font(.caption)
                    
                    Spacer()
                    
                    Text(item.text).font(.caption).bold().foregroundStyle(.mint)
                }.frame(maxWidth: .infinity, alignment: .leading).contentShape(Rectangle())
            }
        }
    }
}

struct iOSAppWidget: Widget {
    let kind: String = "iOSAppWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                iOSAppWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                iOSAppWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName(E.Strings.Title.widgetName)
        .description(E.Strings.Description.descriptionWidget)
    }
}


