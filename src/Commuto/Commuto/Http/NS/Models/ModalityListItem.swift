//
//  ModalityListItem.swift
//  Commuto
//

struct ModalityListItem: Codable {
    let name: String
    let accessibilityName: String
    let nameNesProperties: NesProperties
    let actualTrack: String?
    let iconNesProperties: NesProperties?
}
