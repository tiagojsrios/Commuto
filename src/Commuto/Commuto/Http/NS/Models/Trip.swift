//
//  Trip.swift
//  Commuto
//

struct Trip: Codable {
    let uid: String
    let ctxRecon: String
    let status: TripStatus
    let type: TripType
    let legs: [Leg]
    let transfers: Int
    let optimal: Bool
    let realtime: Bool
    let actualDurationInMinutes: Int?
    let plannedDurationInMinutes: Int?
    let punctuality: Double?
    let crowdForecast: CrowdForecast?
    let routeId: String?
    let sourceCtxRecon: String?
    let eco: Eco?
    let primaryMessage: PrimaryMessage?
    let messages: [Message]?
    let fareLegs: [FareLeg]?
    let fareOptions: TripFareOptions?
    let fareRoute: FareRoute?
    let fares: [TripSalesFare]?
    let productFare: TripTravelFare?
    let labelListItems: [LabelListItem]?
    let modalityListItems: [ModalityListItem]?
    let overviewPolyLine: [Coordinate]?
    let nsiLink: NsiLink?
    let bookingUrl: Link?
    let shareUrl: Link?
    let registerJourney: JourneyRegistrationParameters?
    let travelAssistanceInfo: TravelAssistanceInfo?
}
