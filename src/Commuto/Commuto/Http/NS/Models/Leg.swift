//
//  Leg.swift
//  Commuto
//

struct Leg: Codable {
    let origin: TripOriginDestination
    let destination: TripOriginDestination
    let stops: [Stop]
    let cancelled: Bool
    let partCancelled: Bool
    let reachable: Bool
    let alternativeTransport: Bool
    let isAfterCancelledLeg: Bool
    let isOnOrAfterCancelledLeg: Bool
    let changePossible: Bool
    let preSteps: [Step]
    let postSteps: [Step]
    let idx: String?
    let name: String?
    let direction: String?
    let travelType: LegTravelType?
    let crowdForecast: CrowdForecast?
    let punctuality: Double?
    let distanceInMeters: Int?
    let plannedDurationInMinutes: Int?
    let actualDurationInMinutes: Int?
    let transferTimeToNextLeg: Int?
    let minimallyAddedChangeTime: Int?
    let bicycleSpotCount: Int?
    let changeCouldBePossible: Bool?
    let crossPlatformTransfer: Bool?
    let shorterStock: Bool?
    let shorterStockWarning: String?
    let shorterStockClassification: ShorterStockClassification?
    let journeyDetailRef: String?
    let recognizableDestination: String?
    let product: ProductInterface?
    let duration: Duration?
    let nesProperties: NesProperties?
    let checkinStep: CheckinStep?
    let sharedModality: SharedModality?
    let steps: [Step]?
    let notes: [Note]?
    let messages: [Message]?
    let journeyDetail: [JourneyDetailLink]?
    let overviewPolyLine: [Coordinate]?
    let coordinates: [[Double]]?
    let ticketActions: [TicketAction]?
    let transferMessages: [TransferMessage]?
    let travelAssistanceArrival: ServiceBookingInfo?
    let travelAssistanceDeparture: ServiceBookingInfo?
}
