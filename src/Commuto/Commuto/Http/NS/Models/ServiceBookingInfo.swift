//
//  ServiceBookingInfo.swift
//  Commuto
//

struct ServiceBookingInfo: Codable {
    let name: String
    let tripLegIndex: String
    let canChangeAssistance: Bool
    let defaultAssistanceValue: Bool
    let serviceTypeIds: [String]
    let stationUic: String?
    let message: String?
}
