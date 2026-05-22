//
//  TripFareOptions.swift
//  Commuto
//

struct TripFareOptions: Codable {
    let isEticketBuyable: Bool
    let isInternational: Bool
    let isInternationalBookable: Bool
    let isPossibleWithOvChipkaart: Bool
    let isTotalPriceUnknown: Bool
    let reasonEticketNotBuyable: EticketNotBuyableReason?
    let salesOptions: [SalesOption]?
    let supplementsBasedOnSelectedFare: [TripFareSupplement]?
}
