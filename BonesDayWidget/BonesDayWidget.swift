//
//  BonesDayWidget.swift
//  BonesDayWidget
//
//  Created by Matthew Wyskiel on 10/25/21.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> BonesDayEntry {
        BonesDayEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (BonesDayEntry) -> ()) {
        if context.isPreview {
            completion(BonesDayEntry(date: Date(), bonesDay: true))
        } else {
            Task.init {
                let bonesHistory = try? await BonesDayHistoryService.getBonesHistory()
                
                let formatter = DateFormatter()
                formatter.dateFormat = "dd-MM-yyyy"
                let dateString = formatter.string(from: Date())
                
                let bonesDay = bonesHistory?[dateString]?.bones
                
                completion(BonesDayEntry(date: Date(), bonesDay: bonesDay))
            }
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task.init {
            let bonesHistory = try? await BonesDayHistoryService.getBonesHistory()
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            let dateString = formatter.string(from: Date())
            
            let bonesDay = bonesHistory?[dateString]?.bones
            
            let timeline = Timeline(entries: [BonesDayEntry(date: Date(), bonesDay: bonesDay)], policy: .atEnd)
            
            completion(timeline)
        }
    }
}

struct BonesDayEntry: TimelineEntry {
    let date: Date
    var bonesDay: Bool? = nil
}

struct BonesDayWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        BonesDayView(bonesDay: entry.bonesDay)
            .unredacted()
    }
}

@main
struct BonesDayWidget: Widget {
    let kind: String = "BonesDayWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            BonesDayWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Bones Day")
        .description("Is it a bones day? Let's find out!")
        .supportedFamilies([.systemSmall])
    }
}

struct BonesDayWidget_Previews: PreviewProvider {
    static var previews: some View {
        BonesDayWidgetEntryView(entry: BonesDayEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        BonesDayWidgetEntryView(entry: BonesDayEntry(date: Date(), bonesDay: true))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        BonesDayWidgetEntryView(entry: BonesDayEntry(date: Date(), bonesDay: false))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
