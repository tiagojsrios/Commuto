//
//  Note.swift
//  Commuto
//

struct Note: Codable {
    let isPresentationRequired: Bool
    let value: String?
    let shortValue: String?
    let key: String?
    let accessibilityValue: String?
    let priority: Int?
    let routeIdxFrom: Int?
    let routeIdxTo: Int?
    let noteType: NoteType?
    let category: NoteCategory?
    let nesProperties: NesProperties?
    let link: Link?
}
