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
        VStack(alignment: .leading) {
            
            ScrollView {
                HStack(spacing: 0) {
                    // Column 1 - Back button
                    HStack {
                        Button(action: { showSettings = false }) {
                            Image(systemName: "chevron.left")
                                .padding(2)
                                .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                        Spacer()
                    }

                    // Column 2 - Title
                    Text("Settings")
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
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Walking Time (minutes)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

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
            .padding(.bottom, 8)
            
            
            HStack {
                Spacer()
                Button("Save") {
                    showSettings = false
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.bottom, 15)
        }
        .frame(width: 250, height: 300)
    }
}
