//
//  TripSalesFare.swift
//  Commuto
//

struct TripSalesFare: Codable {
    let discountType: DiscountType?
    let product: TripSalesFareProduct?
    let travelClass: TravelClass?
    let link: String?
    let priceInCents: Int?
    let priceInCentsExcludingSupplement: Int?
    let supplementInCents: Int?
}
