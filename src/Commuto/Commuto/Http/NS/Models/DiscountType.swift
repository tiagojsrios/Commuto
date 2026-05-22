//
//  DiscountType.swift
//  Commuto
//

enum DiscountType: String, Codable {
    case noDiscount = "NO_DISCOUNT"
    case discount20Percent = "DISCOUNT_20_PERCENT"
    case discount40Percent = "DISCOUNT_40_PERCENT"
    case noCharge = "NO_CHARGE"
    case other = "OTHER"
}
