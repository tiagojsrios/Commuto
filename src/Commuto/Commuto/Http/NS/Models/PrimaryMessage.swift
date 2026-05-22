//
//  PrimaryMessage.swift
//  Commuto
//

struct PrimaryMessage: Codable {
    let title: String
    let type: PrimaryMessageType
    let nesProperties: NesProperties
    let message: Message?
}
