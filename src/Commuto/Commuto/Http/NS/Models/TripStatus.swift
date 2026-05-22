//
//  TripStatus.swift
//  Commuto
//

enum TripStatus: String, Codable {
    case cancelled = "CANCELLED"
    case changeNotPossible = "CHANGE_NOT_POSSIBLE"
    case alternativeTransport = "ALTERNATIVE_TRANSPORT"
    case disruption = "DISRUPTION"
    case maintenance = "MAINTENANCE"
    case uncertain = "UNCERTAIN"
    case replacement = "REPLACEMENT"
    case additional = "ADDITIONAL"
    case special = "SPECIAL"
    case normal = "NORMAL"
}
