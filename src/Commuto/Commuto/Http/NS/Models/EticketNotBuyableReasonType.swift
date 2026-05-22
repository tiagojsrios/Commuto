//
//  EticketNotBuyableReasonType.swift
//  Commuto
//

enum EticketNotBuyableReasonType: String, Codable {
    case unknownPrice = "UNKNOWN_PRICE"
    case tooManySeparateParts = "TOO_MANY_SEPARATE_PARTS"
    case tooFarInPast = "TOO_FAR_IN_PAST"
    case tooFarInFuture = "TOO_FAR_IN_FUTURE"
    case stationNotOpenYet = "STATION_NOT_OPEN_YET"
    case tripIsNotDomestic = "TRIP_IS_NOT_DOMESTIC"
    case viaStationRequested = "VIA_STATION_REQUESTED"
    case noTrainLegsInTrip = "NO_TRAIN_LEGS_IN_TRIP"
    case nonContinuousTrainLegs = "NON_CONTINUOUS_TRAIN_LEGS"
}
