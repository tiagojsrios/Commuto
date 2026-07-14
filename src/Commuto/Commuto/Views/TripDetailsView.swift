//
//  TripDetailsView.swift
//  Commuto
//

import SwiftUI

struct TripDetailsView: View {
    @Binding var showTripDetails: Bool
    let trip: Trip?

    var body: some View {
        VStack(alignment: .leading) {

            HStack(spacing: 0) {
                // Column 1 - Back button
                HStack {
                    Button(action: { showTripDetails = false }) {
                        Image(systemName: "chevron.left")
                            .padding(2)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    Spacer()
                }
                .frame(maxWidth: .infinity)

                // Column 2 - Title
                Text("Trip Details")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)

                // Column 3 - Spacer matching chevron size
                HStack {
                    Spacer()
                    Image(systemName: "chevron.left")
                        .hidden() // Same size as the back button, but invisible
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.top, 15)

            Divider()
                .padding(.bottom, 8)

            if trip == nil {
                Text("No trips available")
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        TripRow(trip: trip!)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.bottom, 15)
            }
        }
        .frame(width: 250, height: 300)
    }
}

struct TripRow: View {
    @AppStorage("walkingTimeMinutes") private var walkingTimeMinutes = 0
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
                .padding(.bottom, 6)
            
            // Walking step, if applicable
            if walkingTimeMinutes > 0, let firstLeg = trip.legs.first {
                WalkingStepRow(
                    minutes: walkingTimeMinutes,
                    arrivalTime: firstLeg.origin.plannedDateTime
                )
            }

            // Timeline of legs
            VStack(alignment: .leading, spacing: 0) {
                ForEach(Array(trip.legs.enumerated()), id: \.offset) { legIndex, leg in
                    LegTimelineRow(leg: leg, isLast: legIndex == trip.legs.count - 1)
                }
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
        VStack(alignment: .leading, spacing: 0) {

            // Origin row
            HStack(alignment: .center, spacing: 8) {
                Circle()
                    .fill(leg.cancelled ? .red : .blue)
                    .frame(width: 10, height: 10)
                StopRow(
                    label: "From",
                    name: leg.origin.name ?? "Unknown",
                    time: leg.origin.plannedDateTime,
                    actualTime: leg.origin.actualDateTime,
                    plannedTrack: leg.origin.plannedTrack,
                    actualTrack: leg.origin.actualTrack
                )
            }

            // Line + transport info
            HStack(alignment: .center, spacing: 8) {
                // Vertical line, aligned under the circle
                Rectangle()
                    .fill(.secondary.opacity(0.4))
                    .frame(width: 2)
                    .frame(maxHeight: .infinity)
                    .padding(.leading, 4)

                // Transport info
                if let product = leg.product {
                    HStack(spacing: 6) {
                        Image(systemName: iconForType(product.type))
                            .font(.caption)
                        Text(product.displayName ?? product.shortCategoryName ?? product.type.rawValue)
                            .font(.caption)
                        if let number = product.number {
                            Text("· \(number)")
                                .font(.caption)
                        }
                        if let direction = leg.direction {
                            Text("→ \(direction)")
                                .font(.caption)
                        }
                    }
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.secondary.opacity(0.1), in: RoundedRectangle(cornerRadius: 6))
                }
            }
            .frame(minHeight: 32)

            // Destination row
            HStack(alignment: .center, spacing: 8) {
                Circle()
                    .fill(leg.cancelled ? .red : .blue)
                    .frame(width: 10, height: 10)
                StopRow(
                    label: "To",
                    name: leg.destination.name ?? "Unknown",
                    time: leg.destination.plannedDateTime,
                    actualTime: leg.destination.actualDateTime,
                    plannedTrack: leg.destination.plannedTrack,
                    actualTrack: leg.destination.actualTrack
                )
            }
            .padding(.bottom, 6)

            // Transfer badge
            if !isLast {
                HStack(spacing: 4) {
                    Spacer()
                        .frame(width: 18)
                    HStack(spacing: 4) {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .font(.caption2)
                        Text("Transfer")
                            .font(.caption2)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.orange.opacity(0.2), in: Capsule())
                    .foregroundStyle(.orange)
                }
                .padding(.vertical, 10)
                .padding(.bottom, 6)
            }
        }
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

struct StopRow: View {
    let label: String
    let name: String
    let time: String?
    let actualTime: String?
    let plannedTrack: String?
    let actualTrack: String?

    private var isDelayed: Bool {
        guard let planned = time, let actual = actualTime else { return false }
        return planned != actual
    }

    private var trackChanged: Bool {
        guard let planned = plannedTrack, let actual = actualTrack else { return false }
        return planned != actual
    }

    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            // From / To label
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
                .frame(width: 30, alignment: .leading)

            // Station name
            Text(name)
                .font(.subheadline)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, alignment: .leading)

            // Time
            VStack(alignment: .trailing, spacing: 1) {
                if let planned = time {
                    Text(formatTime(planned))
                        .font(.caption)
                        .foregroundStyle(isDelayed ? .secondary : .primary)
                        .strikethrough(isDelayed)
                }
                if isDelayed, let actual = actualTime {
                    Text(formatTime(actual))
                        .font(.caption)
                        .foregroundStyle(.red)
                }
            }

            // Platform
            if let track = plannedTrack {
                Text("- \(trackChanged ? (actualTrack ?? track) : track)")
                    .font(.caption)
                    .foregroundStyle(trackChanged ? .orange : .secondary)
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
}

struct WalkingStepRow: View {
    let minutes: Int
    let arrivalTime: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 8) {
                Circle()
                    .fill(.green)
                    .frame(width: 10, height: 10)

                HStack(spacing: 4) {
                    Text("Leave by")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .frame(width: 30, alignment: .leading)

                    Text(departureTime ?? "—")
                        .font(.subheadline)
                        .fontWeight(.medium)

                    Spacer()
                }
            }

            HStack(alignment: .center, spacing: 8) {
                Rectangle()
                    .fill(.secondary.opacity(0.4))
                    .frame(width: 2)
                    .frame(maxHeight: .infinity)
                    .padding(.leading, 4)

                HStack(spacing: 6) {
                    Image(systemName: "figure.walk")
                        .font(.caption)
                    Text("Walk · \(minutes) min\(minutes == 1 ? "" : "s")")
                        .font(.caption)
                }
                .foregroundStyle(.secondary)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(.secondary.opacity(0.1), in: RoundedRectangle(cornerRadius: 6))
            }
            .frame(minHeight: 32)
            .padding(.bottom, 16)
        }
    }

    private var departureTime: String? {
        guard let arrivalTime,
              let formatter = ISO8601DateFormatter().date(from: arrivalTime) as Date? else {
            return nil
        }
        let adjusted = formatter.addingTimeInterval(-Double(minutes) * 60)
        let display = DateFormatter()
        display.dateFormat = "HH:mm"
        return display.string(from: adjusted)
    }
}
