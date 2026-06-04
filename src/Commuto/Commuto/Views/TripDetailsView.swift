//
//  TripDetailsView.swift
//  Commuto
//

import SwiftUI

struct TripDetailsView: View {
    @Binding var showTripDetails: Bool
    let trip: Trip?

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            // Header
            HStack(alignment: .center) {
                Button(action: { showTripDetails = false }) {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
                .buttonStyle(.plain)
                Spacer()
                Text("Trip Details")
                    .font(.headline)
                Spacer()
            }

            Divider()

            if trip == nil {
                Text("No trips available")
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        TripRow(trip: trip!)
                    }
                }
            }
        }
        .padding(.vertical, 4)
        .frame(width: 250, height: 400)
    }
}

struct TripRow: View {
    let trip: Trip

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            // Trip header
            HStack {
                Image(systemName: "tram.fill")
                Text("Trip 1")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Spacer()
            }

            Divider()

            // Timeline of legs
            ForEach(Array(trip.legs.enumerated()), id: \.offset) { legIndex, leg in
                LegTimelineRow(leg: leg, isLast: legIndex == trip.legs.count - 1)
            }
        }
        .padding(10)
        .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
    }
}

struct LegTimelineRow: View {
    let leg: Leg
    let isLast: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 12) {

            // Timeline line + dot
            VStack(spacing: 0) {
                Circle()
                    .fill(leg.cancelled ? .red : .blue)
                    .frame(width: 10, height: 10)
                if !isLast {
                    Rectangle()
                        .fill(.secondary.opacity(0.4))
                        .frame(width: 2)
                        .frame(maxHeight: .infinity)
                }
            }
            .frame(width: 10)
            .padding(.top, 3)

            // Leg content
            VStack(alignment: .leading, spacing: 4) {
                // Origin
                HStack {
                    Text(leg.origin.name ?? "Unknown")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    Spacer()
                    if let time = leg.origin.plannedDateTime {
                        Text(formatTime(time))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }

                // Transport info
                if let product = leg.product {
                    HStack(spacing: 4) {
                        Image(systemName: iconForType(product.type))
                            .font(.caption)
                        Text(product.displayName ?? product.shortCategoryName ?? product.type.rawValue)
                            .font(.caption)
                        if let number = product.number {
                            Text("· \(number)")
                                .font(.caption)
                        }
                    }
                    .foregroundStyle(.secondary)
                    .padding(.vertical, 2)
                }

                // Transfer badge
                if !isLast {
                    Text("Transfer")
                        .font(.caption2)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(.orange.opacity(0.2), in: Capsule())
                        .foregroundStyle(.orange)
                }

                // Destination (only on last leg)
                if isLast {
                    HStack {
                        Text(leg.destination.name ?? "Unknown")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        Spacer()
                        if let time = leg.destination.plannedDateTime {
                            Text(formatTime(time))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.top, 2)
                }
            }
        }
    }

    private func formatTime(_ isoString: String) -> String {
        let formatter = ISO8601DateFormatter()
        guard let date = formatter.date(from: isoString) else { return isoString }
        let display = DateFormatter()
        display.dateFormat = "HH:mm"
        return display.string(from: date)
    }

    private func iconForType(_ type: TransportType) -> String {
        switch type {
        case .train: return "tram.fill"
        case .bus: return "bus.fill"
        case .tram: return "tram.fill"
        case .metro: return "metro"
        case .ferry: return "ferry.fill"
        case .walk: return "figure.walk"
        case .bike: return "bicycle"
        case .car: return "car.fill"
        case .taxi: return "car.fill"
        default: return "questionmark.circle"
        }
    }
}
