//
//  TravelAdvice.swift
//  Commuto
//

struct TravelAdvice: Codable {
    let source: TravelAdviceSource
    let trips: [Trip]
    let message: String?
    let scrollRequestBackwardContext: String?
    let scrollRequestForwardContext: String?
    let travelAdviceMessage: TravelAdviceMessage?
}
