//
//  MessageType.swift
//  Commuto
//

enum MessageType: String, Codable {
    case maintenance = "MAINTENANCE"
    case disruption = "DISRUPTION"
    case shortened = "SHORTENED"
}
