//
//  SharedModality.swift
//  Commuto
//

struct SharedModality: Codable {
    let provider: String
    let availability: Bool
    let nearByMeMapping: SharedModalityType
    let name: String?
    let planIcon: String?
}
