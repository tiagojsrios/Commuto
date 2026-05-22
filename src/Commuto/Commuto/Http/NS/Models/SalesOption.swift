//
//  SalesOption.swift
//  Commuto
//

struct SalesOption: Codable {
    let type: SalesOptionType
    let betterOption: Bool
    let labelText: String?
    let recommendationText: String?
    let priceInCents: Int?
    let originalPrice: Int?
    let permilleFullTariff: Int?
}
