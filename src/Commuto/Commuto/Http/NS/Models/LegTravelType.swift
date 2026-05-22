//
//  LegTravelType.swift
//  Commuto
//

enum LegTravelType: String, Codable {
    case publicTransit = "PUBLIC_TRANSIT"
    case walk = "WALK"
    case transfer = "TRANSFER"
    case bike = "BIKE"
    case car = "CAR"
    case kiss = "KISS"
    case taxi = "TAXI"
    case unknown = "UNKNOWN"
}
