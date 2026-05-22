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

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Button(action: { showSettings = false }) {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
                .buttonStyle(.plain)
                Spacer()
            }

            Text("Settings")
                .font(.headline)

            VStack(alignment: .leading, spacing: 8) {
                Text("API Key")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                SecureField("Enter your API key", text: $apiKey)
                    .textFieldStyle(.roundedBorder)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Departure Station")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                TextField("e.g. Rotterdam Centraal", text: $departureStation)
                    .textFieldStyle(.roundedBorder)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Arrival Station")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                TextField("e.g. Schiphol Airport", text: $arrivalStation)
                    .textFieldStyle(.roundedBorder)
            }

            HStack {
                Spacer()
                Button("Save") {
                    showSettings = false
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        .frame(width: 220)
    }
}
