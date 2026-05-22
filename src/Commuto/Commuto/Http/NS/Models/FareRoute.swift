//
//  FareRoute.swift
//  Commuto
//

struct FareRoute: Codable {
    let origin: FareLegStop
    let destination: FareLegStop
    let routeId: String?
}
