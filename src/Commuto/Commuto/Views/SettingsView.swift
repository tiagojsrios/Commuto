//
//  SettingsView.swift
//  Commuto
//

import SwiftUI

struct SettingsView: View {
    @Binding var showSettings: Bool
    @AppStorage("apiKey") private var apiKey = ""
    @AppStorage("departureStation") private var departureStation = ""
    @AppStorage("arrivalStation") private var arrivalStation = ""
    @AppStorage("walkingTimeMinutes") private var walkingTimeMinutes = 0

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
                    showSettings = false
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding(16)
        .frame(width: 320)
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
