//
//  NextTripCard.swift
//  Commuto
//

import SwiftUI

struct NextTripCard: View {
    @ObservedObject var travelState: CommutoViewModel

    private var travel: Travel? { travelState.selectedTravel }

    private var countdownText: String {
        guard let travel else { return travelState.displayText }
        return travel.countdownText
    }

    private var statusInfo: (text: String, color: Color)? {
        guard let travel else { return nil }
        switch travel.status {
        case .cancelled:
            return ("Cancelled", .red)
        case .disrupted:
            return ("Disrupted", .orange)
        case .onTime:
            return ("On time", .green)
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Label("Next departure", systemImage: "tram.fill")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
                if let statusInfo {
                    Text(statusInfo.text)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(statusInfo.color.opacity(0.15), in: Capsule())
                        .foregroundStyle(statusInfo.color)
                }
            }

            if travelState.travels.count > 1 {
                HStack {
                    Button(action: travelState.selectPreviousTravel) {
                        Image(systemName: "chevron.left")
                    }
                    .disabled(travelState.selectedTravelIndex == 0)

                    Spacer()

                    Text("Trip \(travelState.selectedTravelIndex + 1) of \(travelState.travels.count)")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Spacer()

                    Button(action: travelState.selectNextTravel) {
                        Image(systemName: "chevron.right")
                    }
                    .disabled(travelState.selectedTravelIndex == travelState.travels.count - 1)
                }
                .buttonStyle(.plain)
                .font(.caption)
                .foregroundStyle(.secondary)
            }

            Text(countdownText)
                .font(.system(size: 26, weight: .bold, design: .rounded))
                .foregroundStyle(travel == nil && travelState.nextTravel == nil ? .red : .primary)

            if let travel, let origin = travel.origin?.name, let destination = travel.destination?.name {
                HStack(spacing: 6) {
                    Text(origin)
                    Image(systemName: "arrow.right")
                        .font(.caption)
                    Text(destination)
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(1)

                if travel.transfers > 0 {
                    Text("\(travel.transfers) transfer\(travel.transfers == 1 ? "" : "s")")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            } else {
                Text("No trips available")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle(padding: 14)
    }
}
