//
//  TicketAction.swift
//  Commuto
//

struct TicketAction: Codable {
    let type: TicketActionType
    let fromUicCode: String?
    let toUicCode: String?
}
