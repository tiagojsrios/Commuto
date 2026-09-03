//
//  CommutoApp.swift
//  Commuto
//

import SwiftUI

@main
struct CommutoApp : App {
    @StateObject private var commutoViewModel = CommutoViewModel()
    @State private var showSettings = false

    var body: some Scene {
        MenuBarExtra {
            VStack(alignment: .leading, spacing: 0) {
                if showSettings {
                    SettingsView(showSettings: $showSettings, travelState: commutoViewModel)
                } else {
                    MainMenuView(showSettings: $showSettings, travelState: commutoViewModel)
                }
            }
            .padding(.vertical, 4)
        } label: {
            HStack {
                Image(systemName: "tram.fill")
                Text(commutoViewModel.travel.getDisplayText())
            }
        }
        .menuBarExtraStyle(.window)
    }
}
