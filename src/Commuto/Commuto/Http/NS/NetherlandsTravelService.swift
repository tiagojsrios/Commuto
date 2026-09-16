//
//  NetherlandsTravelService.swift
//  Commuto
//

import Foundation

/// Abstraction over NS's trip-fetching HTTP call, so `NetherlandsTravelService`
/// doesn't depend on `NSHttpClient` concretely. `NSHttpClient` conforms to this.
protocol TripFetching {
    func getTrips(from: String, to: String) async -> TravelAdvice?
}

/// Fetches upcoming NS trips and combines them with the user's configured
/// walking time to produce `Travel` values ready for display.
class NetherlandsTravelService: TravelProviding {
    private let httpClient: TripFetching

    init(httpClient: TripFetching = NSHttpClient()) {
        self.httpClient = httpClient
    }

    func fetchUpcomingTravels(from: String, to: String, walkingTimeMinutes: Int) async -> [Travel] {
        let response = await httpClient.getTrips(from: from, to: to)
        let trips = response?.trips ?? []
        return trips.map { Travel(nsTrip: $0).addingWalk(minutesBeforeDeparture: walkingTimeMinutes) }
    }
}
