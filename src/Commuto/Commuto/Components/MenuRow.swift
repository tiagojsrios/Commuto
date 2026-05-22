//
//  MenuRow.swift
//  Commuto
//

import SwiftUI

struct MenuRow: View {
    let icon: String
    let title: String
    let action: () -> Void

    @State private var isHovered = false

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .frame(width: 16)
                .foregroundStyle(.primary)
            Text(title)
                .font(.system(size: 13))
            Spacer()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(isHovered ? Color.accentColor : Color.clear)
        .foregroundStyle(isHovered ? .white : .primary)
        .contentShape(Rectangle())
        .onHover { isHovered = $0 }
        .onTapGesture { action() }
    }
}
