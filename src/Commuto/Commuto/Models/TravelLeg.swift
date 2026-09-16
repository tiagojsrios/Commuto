//
//  TravelLeg.swift
//  Commuto
//

struct TravelLeg {
    let origin: TravelStop
    let destination: TravelStop
    let transportIcon: String?
    let transportLabel: String?
    let lineNumber: String?
    let direction: String?
    let isCancelled: Bool
    let isWalking: Bool
}
