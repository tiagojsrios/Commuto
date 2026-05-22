//
//  TripFareSupplement.swift
//  Commuto
//

struct TripFareSupplement: Codable {
    let supplementPriceInCents: Int
    let supplementType: SupplementType?
    let fromUICCode: String?
    let toUICCode: String?
    let link: Link?
}
