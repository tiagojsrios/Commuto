//
//  CommutoViewModel.swift
//  Commuto
//

import SwiftUI
import Combine

class CommutoViewModel: ObservableObject {
    @Published var travels: [Travel] = []
    @Published var nextTravel: Travel?
    @Published var selectedTravelIndex: Int = 0
    @Published var isLoading = false

    private var timer: Timer?
    private let travelProvider: TravelProviding
    @AppStorage("departureStation") private var departureStation = ""
    @AppStorage("arrivalStation") private var arrivalStation = ""
    @AppStorage("walkingTimeMinutes") private var walkingTimeMinutes = 0

    var selectedTravel: Travel? {
        travels.indices.contains(selectedTravelIndex) ? travels[selectedTravelIndex] : nil
    }

    /// Text shown in the menu bar: the countdown to the next reachable travel.
    var displayText: String {
        guard let nextTravel else { return "Error" }
        return nextTravel.countdownText
    }

    func selectPreviousTravel() {
        guard selectedTravelIndex > 0 else { return }
        selectedTravelIndex -= 1
    }

    func selectNextTravel() {
        guard selectedTravelIndex < travels.count - 1 else { return }
        selectedTravelIndex += 1
    }

    init(travelProvider: TravelProviding = NetherlandsTravelService()) {
        self.travelProvider = travelProvider

        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
            Task {
                await self.run()
            }
        }

        Task {
            await self.run()
        }
    }

    func refresh() {
        Task {
            await self.run()
        }
    }

    func run() async {
        await MainActor.run { isLoading = true }

        let travels = await travelProvider.fetchUpcomingTravels(
            from: departureStation,
            to: arrivalStation,
            walkingTimeMinutes: walkingTimeMinutes
        )
        let reachableIndex = travels.reachableIndex()

        await MainActor.run {
            self.travels = travels
            self.selectedTravelIndex = reachableIndex ?? 0
            self.nextTravel = reachableIndex.map { travels[$0] }
            self.isLoading = false
        }
    }
}
