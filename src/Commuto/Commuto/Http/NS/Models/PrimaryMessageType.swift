//
//  PrimaryMessageType.swift
//  Commuto
//

enum PrimaryMessageType: String, Codable {
    case tripCancelled = "TRIP_CANCELLED"
    case legCancelled = "LEG_CANCELLED"
    case legTransferImpossible = "LEG_TRANSFER_IMPOSSIBLE"
    case alternativeTransport = "ALTERNATIVE_TRANSPORT"
    case disruption = "DISRUPTION"
    case maintenance = "MAINTENANCE"
    case replacement = "REPLACEMENT"
    case additional = "ADDITIONAL"
    case shortenedTrain = "SHORTENED_TRAIN"
}
