//
//  CardStyle.swift
//  Commuto
//

import SwiftUI

struct CardStyle: ViewModifier {
    var padding: CGFloat = 12
    var cornerRadius: CGFloat = 14

    func body(content: Content) -> some View {
        content
            .padding(padding)
            .background(.quaternary, in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
    }
}

extension View {
    func cardStyle(padding: CGFloat = 12, cornerRadius: CGFloat = 14) -> some View {
        modifier(CardStyle(padding: padding, cornerRadius: cornerRadius))
    }
}
