//
//  TravelProviding.swift
//  Commuto
//

/// Country-agnostic seam for fetching upcoming travels. Each supported
/// country implements this independently (e.g. `NetherlandsTravelService`),
/// calling its own transport API and mapping the result into `Travel` values.
protocol TravelProviding {
    func fetchUpcomingTravels(from: String, to: String, walkingTimeMinutes: Int) async -> [Travel]
}
