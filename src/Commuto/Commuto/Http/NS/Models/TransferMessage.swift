//
//  TransferMessage.swift
//  Commuto
//

struct TransferMessage: Codable {
    let message: String
    let accessibilityMessage: String
    let messageNesProperties: NesProperties
    let type: TransferMessageType
    let iconNesProperties: NesProperties?
}
