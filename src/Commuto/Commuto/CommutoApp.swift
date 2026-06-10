//
//  CommutoApp.swift
//  Commuto
//

import SwiftUI

@main
struct CommutoApp : App {
    @StateObject private var commutoViewModel = CommutoViewModel()
    @State private var showSettings = false
    @State private var showTripDetails = false
    
    var body: some Scene {
        MenuBarExtra {
            VStack(alignment: .leading, spacing: 0) {
                if showSettings {
                    SettingsView(showSettings: $showSettings)
                } else if showTripDetails {
                    TripDetailsView(showTripDetails: $showTripDetails, trip: commutoViewModel.travel.trip)
                } else {
                    MainMenuView(showSettings: $showSettings, showTripDetails: $showTripDetails)
                }
            }
            .padding(.vertical, 4)
            .frame(width: 300)
        } label: {
            HStack {
                Image(systemName: "tram.fill")
                Text(commutoViewModel.travel.getDisplayText())
            }
        }
        .menuBarExtraStyle(.window)
    }
}
