//
//  NetherlandsTravelServiceTests.swift
//  CommutoTests
//

import XCTest
@testable import Commuto

private struct MockTripFetching: TripFetching {
    let advice: TravelAdvice?
    func getTrips(from: String, to: String) async -> TravelAdvice? { advice }
}

final class NetherlandsTravelServiceTests: XCTestCase {
    func testFetchUpcomingTravelsAppliesConfiguredWalkingTime() async throws {
        let formatter = ISO8601DateFormatter()
        let departure = Date().addingTimeInterval(20 * 60)
        let tripJSON = Fixtures.tripJSON(legs: [
            Fixtures.legJSON(origin: Fixtures.stopJSON(planned: formatter.string(from: departure)), destination: Fixtures.stopJSON())
        ])

        let advice = try Fixtures.travelAdvice(tripJSONs: [tripJSON])
        let service = NetherlandsTravelService(httpClient: MockTripFetching(advice: advice))

        let travels = await service.fetchUpcomingTravels(from: "A", to: "B", walkingTimeMinutes: 10)

        XCTAssertEqual(travels.count, 1)
        XCTAssertEqual(travels[0].leaveByTime?.timeIntervalSince1970 ?? 0, departure.addingTimeInterval(-10 * 60).timeIntervalSince1970, accuracy: 1)
    }

    func testFetchUpcomingTravelsWithoutWalkingTimeUsesRawDeparture() async throws {
        let formatter = ISO8601DateFormatter()
        let departure = Date().addingTimeInterval(20 * 60)
        let tripJSON = Fixtures.tripJSON(legs: [
            Fixtures.legJSON(origin: Fixtures.stopJSON(planned: formatter.string(from: departure)), destination: Fixtures.stopJSON())
        ])

        let advice = try Fixtures.travelAdvice(tripJSONs: [tripJSON])
        let service = NetherlandsTravelService(httpClient: MockTripFetching(advice: advice))

        let travels = await service.fetchUpcomingTravels(from: "A", to: "B", walkingTimeMinutes: 0)

        XCTAssertEqual(travels[0].leaveByTime?.timeIntervalSince1970 ?? 0, departure.timeIntervalSince1970, accuracy: 1)
    }

    func testNoTripsReturnsEmptyResult() async throws {
        let advice = try Fixtures.travelAdvice(tripJSONs: [])
        let service = NetherlandsTravelService(httpClient: MockTripFetching(advice: advice))

        let travels = await service.fetchUpcomingTravels(from: "A", to: "B", walkingTimeMinutes: 10)

        XCTAssertTrue(travels.isEmpty)
    }
}
