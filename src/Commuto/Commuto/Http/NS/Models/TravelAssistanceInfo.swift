//
//  TravelAssistanceInfo.swift
//  Commuto
//

struct TravelAssistanceInfo: Codable {
    let isAssistanceRequired: Bool
    let tripRequestId: Int
    let termsAndConditionsLink: String?
}
