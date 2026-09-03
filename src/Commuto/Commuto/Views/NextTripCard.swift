//
//  NextTripCard.swift
//  Commuto
//

import SwiftUI

struct NextTripCard: View {
    @ObservedObject var travelState: CommutoViewModel

    private var trip: Trip? { travelState.selectedTrip }

    private var countdownText: String {
        guard let departure = trip?.legs.first?.origin.actualDateTime ?? trip?.legs.first?.origin.plannedDateTime else {
            return travelState.travel.getDisplayText()
        }
        return TravelState.relativeTime(for: departure)
    }

    private var statusInfo: (text: String, color: Color)? {
        guard let trip else { return nil }
        switch trip.status {
        case .cancelled:
            return ("Cancelled", .red)
        case .disruption, .alternativeTransport, .changeNotPossible, .maintenance, .uncertain:
            return ("Disrupted", .orange)
        default:
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

            if travelState.trips.count > 1 {
                HStack {
                    Button(action: travelState.selectPreviousTrip) {
                        Image(systemName: "chevron.left")
                    }
                    .disabled(travelState.selectedTripIndex == 0)

                    Spacer()

                    Text("Trip \(travelState.selectedTripIndex + 1) of \(travelState.trips.count)")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Spacer()

                    Button(action: travelState.selectNextTrip) {
                        Image(systemName: "chevron.right")
                    }
                    .disabled(travelState.selectedTripIndex == travelState.trips.count - 1)
                }
                .buttonStyle(.plain)
                .font(.caption)
                .foregroundStyle(.secondary)
            }

            Text(countdownText)
                .font(.system(size: 26, weight: .bold, design: .rounded))
                .foregroundStyle(trip == nil && travelState.travel.status == "Error" ? .red : .primary)

            if let trip, let origin = trip.legs.first?.origin.name, let destination = trip.legs.last?.destination.name {
                HStack(spacing: 6) {
                    Text(origin)
                    Image(systemName: "arrow.right")
                        .font(.caption)
                    Text(destination)
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(1)

                if trip.transfers > 0 {
                    Text("\(trip.transfers) transfer\(trip.transfers == 1 ? "" : "s")")
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
