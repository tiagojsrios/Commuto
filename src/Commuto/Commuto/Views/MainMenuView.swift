//
//  MainMenuView.swift
//  Commuto
//

import SwiftUI

struct MainMenuView: View {
    @Binding var showSettings: Bool
    @Binding var showTripDetails: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            MenuRow(icon: "tram.fill", title: "Trip Details") {
                showTripDetails = true
            }

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
        .frame(width: 220)
    }
}
