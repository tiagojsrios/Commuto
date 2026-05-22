//
//  Message.swift
//  Commuto
//

struct Message: Codable {
    let id: String?
    let externalId: String?
    let head: String?
    let text: String?
    let lead: String?
    let type: MessageType?
    let phase: MessagePhase?
    let startDate: String?
    let startTime: String?
    let endDate: String?
    let endTime: String?
    let routeIdxFrom: Int?
    let routeIdxTo: Int?
    let nesProperties: NesProperties?
}
