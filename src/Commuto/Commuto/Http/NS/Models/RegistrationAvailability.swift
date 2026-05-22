//
//  RegistrationAvailability.swift
//  Commuto
//

struct RegistrationAvailability: Codable {
    let seats: Bool
    let bicycle: Bool
    let numberOfSeats: Int?
    let numberOfBicyclePlaces: Int?
}
