//
//  SensawayWidget.swift
//  SensawayWidget
//
//  Created by EBRU KÖSE on 13.08.2024.
//
import WidgetKit
import SwiftUI

struct Alarm: Identifiable, Codable {
    let id: UUID
    let type: AlarmType
    var value: Int
}

enum AlarmType: String, Codable {
    case connectionError = "Connection Error"
    case warning = "Warning"
    case alarm = "Alarm"
    case criticalAlarm = "Critical Alarm"

    var color: Color {
        switch self {
        case .connectionError: return .blue
        case .warning: return .yellow
        case .alarm: return .orange
        case .criticalAlarm: return .red
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let alarms: [Alarm]
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), alarms: [Alarm(id: UUID(), type: .warning, value: 5)])
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        fetchAlarms { alarms in
            let entry = SimpleEntry(date: Date(), alarms: alarms)
            completion(entry)
        }
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        fetchAlarms { alarms in
            let currentDate = Date()
            let entries = [SimpleEntry(date: currentDate, alarms: alarms)]
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
    }
    
    func fetchAlarms(completion: @escaping ([Alarm]) -> Void) {
        guard let url = URL(string: "http...") else {
            print("Invalid URL")
            completion([])
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("API Error: \(error)")
                completion([])
                return
            }

            guard let data = data else {
                print("No data received.")
                completion([])
                return
            }

            do {
                let decodedAlarms = try JSONDecoder().decode([Alarm].self, from: data)
                print("Fetched alarms: \(decodedAlarms)")
                DispatchQueue.main.async {
                    completion(decodedAlarms)
                }
            } catch {
                print("Decoding Error: \(error)")
                completion([])
            }
        }.resume()
    }

    
    
    
}

struct SensawayWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            if let highestAlarm = entry.alarms.max(by: { $0.value < $1.value }) {
                HStack {
                    Circle()
                       // .fill(.blue)
                        .fill(highestAlarm.type.color)
                        .frame(width: 12, height: 12)
                        Spacer()
                    Text("\(highestAlarm.value)")
                       // Text("10")
                        .font(.headline)
                }
            } else {
            Text("No Alarms")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
        }
        .containerBackground(for: .widget ){
            
        }
        .padding()
        .background(Color.black)
        .foregroundColor(.white)
    }
}


@main
struct SensawayWidget: Widget {
    let kind: String = "SensawayWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            SensawayWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.accessoryCircular, .accessoryRectangular, .accessoryInline])
        .configurationDisplayName("Sensaway Alerts")
        .description("Shows the latest alarm alerts.")
    }
}




struct SensawayWidget_Previews: PreviewProvider {
    static var previews: some View {
        SensawayWidgetEntryView(entry: SimpleEntry(date: Date(), alarms: [
            Alarm(id: UUID(), type: .warning, value: 3),
            Alarm(id: UUID(), type: .criticalAlarm, value: 10)
        ]))
        .previewContext(WidgetPreviewContext(family: .accessoryCircular))
    }
}



