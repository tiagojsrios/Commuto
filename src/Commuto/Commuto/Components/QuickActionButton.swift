//
//  QuickActionButton.swift
//  Commuto
//

import SwiftUI

struct QuickActionButton: View {
    let icon: String
    let label: String
    var tint: Color = .primary
    var isDisabled: Bool = false
    let action: () -> Void

    @State private var isHovered = false

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 15, weight: .medium))
                    .frame(width: 34, height: 34)
                    .background(tint.opacity(isHovered ? 0.28 : 0.15), in: Circle())
                    .foregroundStyle(tint)
                Text(label)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.5 : 1)
        .onHover { isHovered = $0 }
    }
}
