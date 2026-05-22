//
//  ProductInterface.swift
//  Commuto
//

struct ProductInterface: Codable {
    let type: TransportType
    let productType: String
    let nameNesProperties: NesProperties
    let notes: [[Note]]
    let categoryCode: String?
    let shortCategoryName: String?
    let longCategoryName: String?
    let displayName: String?
    let number: String?
    let operatorName: String?
    let operatorCode: String?
    let operatorAdministrativeCode: Int?
    let iconNesProperties: NesProperties?
}
