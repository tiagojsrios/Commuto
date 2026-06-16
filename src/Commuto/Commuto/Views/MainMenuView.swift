//
//  MainMenuView.swift
//  Commuto
//

import SwiftUI

struct MainMenuView: View {
    @Binding var showSettings: Bool
    @Binding var showTripDetails: Bool
    @ObservedObject var travelState: CommutoViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            MenuRow(icon: "tram.fill", title: "Trip Details") {
                showTripDetails = true
            }

            MenuRow(icon: travelState.isLoading ? "arrow.clockwise.circle" : "arrow.clockwise", title: travelState.isLoading ? "Refreshing..." : "Refresh") {
                travelState.refresh()
            }
            .disabled(travelState.isLoading)
            .opacity(travelState.isLoading ? 0.5 : 1)
            
            Divider()

            MenuRow(icon: "gear", title: "Settings") {
                showSettings = true
            }

            Divider()

            MenuRow(icon: "power", title: "Exit") {
                NSApplication.shared.terminate(nil)
            }
        }
        .padding(.vertical, 4)
        .frame(width: 300)
    }
}
