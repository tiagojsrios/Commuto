//
//  TransferMessageType.swift
//  Commuto
//

enum TransferMessageType: String, Codable {
    case impossibleTransfer = "IMPOSSIBLE_TRANSFER"
    case special = "SPECIAL"
    case checkoverInstruction = "CHECKOVER_INSTRUCTION"
    case crossPlatform = "CROSS_PLATFORM"
    case transferTime = "TRANSFER_TIME"
}
