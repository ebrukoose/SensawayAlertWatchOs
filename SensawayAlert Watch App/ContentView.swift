//
//  ContentView.swift
//  SensawayAlert Watch App
//
//  Created by EBRU KÖSE on 12.08.2024.
//


import SwiftUI

struct ContentView: View {
    @State private var alarms: [Alarm] = []
    
    var highestAlarmColor: Color {
        return alarms.max(by: { $0.value < $1.value })?.type.color ?? .clear
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Alert List")
                        .font(.headline)
                        .fontWeight(.heavy)
                    Spacer()
                    Circle()
                        .fill(highestAlarmColor)
                        .frame(width: 30, height: 30)
                }
                .padding()
                
                List(alarms.indices, id: \.self) { index in
                    NavigationLink(destination: DetailsView(alarm: $alarms[index])) {
                        HStack {
                            Circle()
                                .fill(alarms[index].type.color)
                                .frame(width: 20, height: 20)
                            Text(LocalizedStringKey(alarms[index].type.rawValue))
                            Spacer()
                            Text("\(alarms[index].value)")
                        }
                    }
                }
            }
            .padding()
            .onAppear {
                fetchAlarms() // API'den alarmları getir
            }
        }
    }
    
    func fetchAlarms() {
        guard let url = URL(string: "http://localhost:3000/alarms") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedAlarms = try? JSONDecoder().decode([Alarm].self, from: data) {
                    DispatchQueue.main.async {
                        alarms = decodedAlarms
                    }
                }
            }
        }.resume()
    }
    
    
    
}







#Preview {
    ContentView()
}








/*
struct ContentView: View {
    @State private var alarms: [Alarm] = [
        Alarm(type: .connectionError, value: 1),
        Alarm(type: .warning, value: 2),
        Alarm(type: .alarm, value: 3),
        Alarm(type: .criticalAlarm, value: 4)
    ]

    var highestAlarmColor: Color {
        return alarms.max(by: { $0.value < $1.value })?.type.color ?? .clear
    }

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Alert List")
                        .font(.headline)
                        .fontWeight(.heavy)
                    Spacer()
                    Circle()
                        .fill(highestAlarmColor)
                        .frame(width: 30, height: 30)
                }
                .padding()

                List(alarms) { alarm in
                    NavigationLink(destination: DetailsView(alarm: alarm)) {
                        HStack {
                            Circle()
                                .fill(alarm.type.color)
                                .frame(width: 20, height: 20)
                            Text(LocalizedStringKey(alarm.type.rawValue))
                            Spacer()
                            Text("\(alarm.value)")
                        }
                    }
                }
            }
            .padding()
        }
    }
}




#Preview {
    ContentView()
}





*/






/*
import SwiftUI


struct ContentView: View {
    
    
    
    @State private var alarms: [Alarm] = [
        Alarm(type: .connectionError, value: 1),
        Alarm(type: .warning, value: 2),
        Alarm(type: .alarm, value: 3),
        Alarm(type: .criticalAlarm, value: 4)
    ]

    var highestAlarmColor: Color {
        return alarms.max(by: { $0.value < $1.value })?.type.color ?? .clear
    }

    var body: some View {
        VStack {
            HStack {
                Text("Alert List")
                    .font(.headline)
                    .fontWeight(.heavy)
                Spacer()
                Circle()
                    .fill(highestAlarmColor)
                    .frame(width: 30, height: 30)
            }
            .padding()

            List(alarms) { alarm in
              
                HStack {
                    Circle()
                        .fill(alarm.type.color)
                        .frame(width: 20, height: 20)
                    Text(LocalizedStringKey(alarm.type.rawValue))
                    Spacer()
                    Text("\(alarm.value)")
                }
            
            }
        }
        .padding()
    }
}






#Preview {
    ContentView()
}
*/
