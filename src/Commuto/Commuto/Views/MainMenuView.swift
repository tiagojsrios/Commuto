//
//  MainMenuView.swift
//  Commuto
//

import SwiftUI

struct MainMenuView: View {
    @Binding var showSettings: Bool
    @ObservedObject var travelState: CommutoViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            NextTripCard(travelState: travelState)

            if let trip = travelState.travel.trip {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Itinerary")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    TripRow(trip: trip)
                }
                .cardStyle(padding: 14)
            }

            QuickActionBar(travelState: travelState, showSettings: $showSettings)
        }
        .padding(16)
        .frame(width: 320)
    }
}

private struct QuickActionBar: View {
    @ObservedObject var travelState: CommutoViewModel
    @Binding var showSettings: Bool

    var body: some View {
        HStack(spacing: 4) {
            QuickActionButton(
                icon: travelState.isLoading ? "arrow.clockwise.circle" : "arrow.clockwise",
                label: travelState.isLoading ? "Refreshing" : "Refresh",
                tint: .blue,
                isDisabled: travelState.isLoading
            ) {
                travelState.refresh()
            }

            QuickActionButton(icon: "gear", label: "Settings", tint: .secondary) {
                showSettings = true
            }

            QuickActionButton(icon: "power", label: "Exit", tint: .red) {
                NSApplication.shared.terminate(nil)
            }
        }
    }
}
