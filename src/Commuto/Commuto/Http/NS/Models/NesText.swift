//
//  NesText.swift
//  Commuto
//

struct NesText: Codable {
    let text: String
    let color: String
    let accessibilityText: String
    let backgroundColor: String?
    let styles: NesTextStyles?
}
