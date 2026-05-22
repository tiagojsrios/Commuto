//
//  JourneyRegistrationParameters.swift
//  Commuto
//

struct JourneyRegistrationParameters: Codable {
    let status: RegistrationStatus
    let bicycleReservationRequired: Bool
    let searchUrl: String
    let url: String?
    let availability: RegistrationAvailability?
}
