//
//  DetailsView.swift
//  SensawayAlert Watch App
//
//  Created by EBRU KÖSE on 13.08.2024.
//
import SwiftUI

struct DetailsView: View {
    @Binding var alarm: Alarm

    var body: some View {
        VStack {
            Circle()
            .fill(alarm.type.color)
            .frame(width: 20, height: 20)
            
                Text(LocalizedStringKey(alarm.type.rawValue))
                    .font(.title3)
                    .padding()
        

            Text("Value: \(alarm.value)")
                .font(.title3)
    
                .padding()
        }
        .navigationTitle("Alarm Detail")
        .padding(.top)
    }

  /*  func updateAlarm(_ alarm: Alarm) {
        guard let url = URL(string: "http://localhost:3000/alarms/\(alarm.id)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(alarm)
            request.httpBody = jsonData
        } catch {
            print("Failed to encode alarm: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Failed to update alarm: \(error)")
            } else {
                print("Alarm updated successfully")
            }
        }.resume()
    }*/
}



#Preview {
    ContentView()
}











/*
struct DetailsView: View {
    let alarm: Alarm

    var body: some View {
        VStack {
            Circle()
            .fill(alarm.type.color)
            .frame(width: 30, height: 30)
            
                Text(LocalizedStringKey(alarm.type.rawValue))
                    .font(.title2)
                    .padding()
        

            Text("Value: \(alarm.value)")
                .font(.title3)
        }
        .navigationTitle("Alarm Detail")
        .padding()
    }
}


*/
