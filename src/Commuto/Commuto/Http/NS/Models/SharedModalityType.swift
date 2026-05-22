//
//  SharedModalityType.swift
//  Commuto
//

enum SharedModalityType: String, Codable {
    case ovFiets = "OV_FIETS"
    case sharedElectricalBike = "SHARED_ELECTRICAL_BIKE"
    case sharedBike = "SHARED_BIKE"
    case sharedScooter = "SHARED_SCOOTER"
    case sharedCar = "SHARED_CAR"
    case unknown = "UNKNOWN"
}
