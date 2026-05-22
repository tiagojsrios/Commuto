//
//  TripTravelFare.swift
//  Commuto
//

struct TripTravelFare: Codable {
    let discountType: DiscountType
    let link: String?
    let priceInCents: Int?
    let priceInCentsExcludingSupplement: Int?
    let supplementInCents: Int?
    let buyableTicketPriceInCents: Int?
    let buyableTicketPriceInCentsExcludingSupplement: Int?
    let buyableTicketSupplementPriceInCents: Int?
    let product: TripTravelFareProduct?
    let travelClass: TravelClass?
}
