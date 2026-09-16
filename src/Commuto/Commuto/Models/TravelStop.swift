//
//  TravelStop.swift
//  Commuto
//

import Foundation

struct TravelStop {
    let name: String
    let plannedTime: Date?
    let actualTime: Date?
    let plannedTrack: String?
    let actualTrack: String?

    var displayTime: Date? { actualTime ?? plannedTime }

    var isDelayed: Bool {
        guard let plannedTime, let actualTime else { return false }
        return plannedTime != actualTime
    }

    var trackChanged: Bool {
        guard let plannedTrack, let actualTrack else { return false }
        return plannedTrack != actualTrack
    }
}
