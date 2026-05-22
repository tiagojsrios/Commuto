//
//  TripOriginDestination.swift
//  Commuto
//

struct TripOriginDestination: Codable {
    let name: String?
    let city: String?
    let countryCode: String?
    let uicCode: String?
    let uicCdCode: String?
    let stationCode: String?
    let quayCode: String?
    let rawLocationName: String?
    let lat: Double?
    let lng: Double?
    let plannedDateTime: String?
    let plannedTimeZoneOffset: Int?
    let plannedTrack: String?
    let actualDateTime: String?
    let actualTimeZoneOffset: Int?
    let actualTrack: String?
    let prognosisType: String?
    let type: LocationType?
    let exitSide: ExitSide?
    let checkinStatus: CheckinStatus?
    let notes: [Note]?
    let travelAssistanceBookingInfo: ServiceBookingInfo?
    let travelAssistanceMeetingPoints: [String]?
    let travelAssistanceMeetingPointDetails: [MeetingPointDetails]?
}
