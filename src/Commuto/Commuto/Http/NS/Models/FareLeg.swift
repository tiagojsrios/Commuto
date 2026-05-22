//
//  FareLeg.swift
//  Commuto
//

struct FareLeg: Codable {
    let origin: TripOriginDestination
    let destination: TripOriginDestination
    let fares: [TripTravelFare]
    let productTypes: [TransportType]
    let `operator`: String?
    let travelDate: String?
}
