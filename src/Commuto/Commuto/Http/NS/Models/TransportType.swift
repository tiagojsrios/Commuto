//
//  TransportType.swift
//  Commuto
//

enum TransportType: String, Codable {
    case train = "TRAIN"
    case bus = "BUS"
    case tram = "TRAM"
    case metro = "METRO"
    case ferry = "FERRY"
    case walk = "WALK"
    case bike = "BIKE"
    case car = "CAR"
    case taxi = "TAXI"
    case sharedModality = "SHARED_MODALITY"
    case unknown = "UNKNOWN"
}
