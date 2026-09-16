//
//  TripDetailsView.swift
//  Commuto
//

import SwiftUI

struct TripRow: View {
    let travel: Travel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(Array(travel.legs.enumerated()), id: \.offset) { legIndex, leg in
                // Walking step, if applicable
                if leg.isWalking {
                    let durationInSeconds = leg.destination.actualTime!.timeIntervalSince(leg.origin.actualTime!)
                    
                    WalkingStepRow(minutes: Int(durationInSeconds / 60), leaveByTime: leg.origin.displayTime!)
                } else {
                    LegTimelineRow(leg: leg, isLast: legIndex == travel.legs.count - 1)
                }
            }
        }
    }
}

struct LegTimelineRow: View {
    let leg: TravelLeg
    let isLast: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            // Origin row
            HStack(alignment: .center, spacing: 8) {
                Circle()
                    .fill(leg.isWalking ? .green : (leg.isCancelled ? .red : .blue))
                    .frame(width: 10, height: 10)
                StopRow(label: leg.isWalking ? "Leave by" : "From", stop: leg.origin)
            }

            // Line + transport info
            HStack(alignment: .center, spacing: 8) {
                // Vertical line, aligned under the circle
                Rectangle()
                    .fill(.secondary.opacity(0.4))
                    .frame(width: 2, height: 32)
                    .padding(.leading, 4)

                // Transport info
                if let label = leg.transportLabel {
                    HStack(spacing: 6) {
                        if let icon = leg.transportIcon {
                            Image(systemName: icon)
                                .font(.caption)
                        }
                        Text(label)
                            .font(.caption)
                        if let number = leg.lineNumber {
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
                    .fill(leg.isWalking ? .green : (leg.isCancelled ? .red : .blue))
                    .frame(width: 10, height: 10)
                StopRow(label: "To", stop: leg.destination)
            }
            .padding(.bottom, 6)

            // Transfer badge (not shown after a walking leg)
            if !isLast && !leg.isWalking {
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
}

struct StopRow: View {
    let label: String
    let stop: TravelStop

    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            // From / To label
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
                .frame(width: 30, alignment: .leading)

            // Station name
            Text(stop.name)
                .font(.subheadline)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, alignment: .leading)

            // Time
            VStack(alignment: .trailing, spacing: 1) {
                if let planned = stop.plannedTime {
                    Text(formatTime(planned))
                        .font(.caption)
                        .foregroundStyle(stop.isDelayed ? .secondary : .primary)
                        .strikethrough(stop.isDelayed)
                }
                if stop.isDelayed, let actual = stop.actualTime {
                    Text(formatTime(actual))
                        .font(.caption)
                        .foregroundStyle(.red)
                }
            }

            // Platform
            if let track = stop.plannedTrack {
                Text("- \(stop.trackChanged ? (stop.actualTrack ?? track) : track)")
                    .font(.caption)
                    .foregroundStyle(stop.trackChanged ? .orange : .secondary)
            }
        }
    }

    private func formatTime(_ date: Date) -> String {
        let display = DateFormatter()
        display.dateFormat = "HH:mm"
        return display.string(from: date)
    }
}

struct WalkingStepRow: View {
    let minutes: Int
    let leaveByTime: Date

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

                    Text(formatTime(leaveByTime))
                        .font(.subheadline)
                        .fontWeight(.medium)

                    Spacer()
                }
            }

            HStack(alignment: .center, spacing: 8) {
                Rectangle()
                    .fill(.secondary.opacity(0.4))
                    .frame(width: 2, height: 32)
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

    private func formatTime(_ date: Date) -> String {
        let display = DateFormatter()
        display.dateFormat = "HH:mm"
        return display.string(from: date)
    }
}
