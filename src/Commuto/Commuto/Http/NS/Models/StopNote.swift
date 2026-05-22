//
//  StopNote.swift
//  Commuto
//

struct StopNote: Codable {
    let type: StopNoteType
    let value: String
    let key: String?
    let priority: Int?
}
