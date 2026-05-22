//
//  CheckinStatus.swift
//  Commuto
//

enum CheckinStatus: String, Codable {
    case checkin = "CHECKIN"
    case checkout = "CHECKOUT"
    case overcheck = "OVERCHECK"
    case detour = "DETOUR"
    case requiredCheckOutIn = "REQUIRED_CHECK_OUT_IN"
    case nothing = "NOTHING"
}
