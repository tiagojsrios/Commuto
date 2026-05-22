//
//  TravelAdviceMessage.swift
//  Commuto
//

struct TravelAdviceMessage: Codable {
    let disruptionIds: [String]
    let nesProperties: NesProperties
    let title: String
}
