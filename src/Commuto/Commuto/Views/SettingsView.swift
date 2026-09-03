//
//  SettingsView.swift
//  Commuto
//

import SwiftUI

struct SettingsView: View {
    @Binding var showSettings: Bool
    @ObservedObject var travelState: CommutoViewModel
    @AppStorage("apiKey") private var apiKey = ""
    @AppStorage("departureStation") private var departureStation = ""
    @AppStorage("arrivalStation") private var arrivalStation = ""
    @AppStorage("walkingTimeMinutes") private var walkingTimeMinutes = 0

    @State private var initialApiKey = ""
    @State private var initialDepartureStation = ""
    @State private var initialArrivalStation = ""
    @State private var initialWalkingTimeMinutes = 0

    private var hasChanges: Bool {
        apiKey != initialApiKey
            || departureStation != initialDepartureStation
            || arrivalStation != initialArrivalStation
            || walkingTimeMinutes != initialWalkingTimeMinutes
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Button(action: { showSettings = false }) {
                    Image(systemName: "chevron.left")
                        .padding(4)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)

                Text("Settings")
                    .font(.headline)

                Spacer()
            }

            VStack(alignment: .leading, spacing: 14) {
                SettingsField(title: "API Key") {
                    SecureField("Enter your API key", text: $apiKey)
                        .textFieldStyle(.roundedBorder)
                }

                SettingsField(title: "Departure Station") {
                    TextField("e.g. Rotterdam Centraal", text: $departureStation)
                        .textFieldStyle(.roundedBorder)
                }

                SettingsField(title: "Arrival Station") {
                    TextField("e.g. Schiphol Airport", text: $arrivalStation)
                        .textFieldStyle(.roundedBorder)
                }

                SettingsField(title: "Walking Time (minutes)") {
                    HStack {
                        TextField("0", value: $walkingTimeMinutes, formatter: NumberFormatter())
                            .textFieldStyle(.roundedBorder)
                            .frame(width: 60)

                        Stepper("", value: $walkingTimeMinutes, in: 0...60)
                            .labelsHidden()

                        Spacer()
                    }
                }
            }
            .cardStyle(padding: 14)

            HStack {
                Spacer()
                Button("Save") {
                    if hasChanges {
                        travelState.refresh()
                    }
                    showSettings = false
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding(16)
        .frame(width: 320)
        .onAppear {
            initialApiKey = apiKey
            initialDepartureStation = departureStation
            initialArrivalStation = arrivalStation
            initialWalkingTimeMinutes = walkingTimeMinutes
        }
    }
}

private struct SettingsField<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            content
        }
    }
}
