//
//  Stop.swift
//  Commuto
//

struct Stop: Codable {
    let borderStop: Bool
    let cancelled: Bool
    let passing: Bool
    let notes: [StopNote]
    let name: String?
    let uicCode: String?
    let uicCdCode: String?
    let countryCode: String?
    let quayCode: String?
    let routeIdx: Int?
    let lat: Double?
    let lng: Double?
    let plannedArrivalDateTime: String?
    let actualArrivalDateTime: String?
    let plannedArrivalTrack: String?
    let actualArrivalTrack: String?
    let plannedArrivalTimeZoneOffset: Int?
    let actualArrivalTimeZoneOffset: Int?
    let arrivalDelayInSeconds: Int?
    let arrivalPrognosisType: String?
    let plannedDepartureDateTime: String?
    let actualDepartureDateTime: String?
    let plannedDepartureTrack: String?
    let actualDepartureTrack: String?
    let plannedDepartureTimeZoneOffset: Int?
    let actualDepartureTimeZoneOffset: Int?
    let departureDelayInSeconds: Int?
    let departurePrognosisType: String?
    let plannedPassingDateTime: String?
    let actualPassingDateTime: String?
}
