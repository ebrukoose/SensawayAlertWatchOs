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

 
