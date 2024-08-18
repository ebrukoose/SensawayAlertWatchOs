//
//  AlarmTypes.swift
//  SensawayAlert
//
//  Created by EBRU KÖSE on 12.08.2024.
//


import Foundation
import SwiftUI

struct Alarm: Identifiable {
    let id = UUID()
    let type: AlarmType
    var value: Int
}

enum AlarmType: String, CaseIterable {
    case connectionError = "Connection Error"
    case warning = "Warning"
    case alarm = "Alarm"
    case criticalAlarm = "Critical Alarm"

    var color: Color {
        switch self {
        case .connectionError:
            return .blue
        case .warning:
            return .yellow
        case .alarm:
            return .orange
        case .criticalAlarm:
            return .red
        }
    }
}
