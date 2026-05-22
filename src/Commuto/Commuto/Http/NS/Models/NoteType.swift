//
//  NoteType.swift
//  Commuto
//

enum NoteType: String, Codable {
    case unknown = "UNKNOWN"
    case attribute = "ATTRIBUTE"
    case infotext = "INFOTEXT"
    case realtime = "REALTIME"
    case ticket = "TICKET"
    case hint = "HINT"
}
