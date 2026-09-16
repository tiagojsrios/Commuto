//
//  TravelTests.swift
//  CommutoTests
//

import XCTest
@testable import Commuto

final class TravelTests: XCTestCase {
    private func makeLeg(originName: String = "A", destinationName: String = "B", planned: Date?) -> TravelLeg {
        TravelLeg(
            origin: TravelStop(name: originName, plannedTime: planned, actualTime: planned, plannedTrack: nil, actualTrack: nil),
            destination: TravelStop(name: destinationName, plannedTime: nil, actualTime: nil, plannedTrack: nil, actualTrack: nil),
            transportIcon: nil,
            transportLabel: nil,
            lineNumber: nil,
            direction: nil,
            isCancelled: false,
            isWalking: false
        )
    }

    // MARK: - leaveByTime / countdown

    func testLeaveByTimeIsFirstLegOrigin() {
        let departure = Date().addingTimeInterval(10 * 60)
        let travel = Travel(status: .onTime, legs: [makeLeg(planned: departure)], transfers: 0)
        XCTAssertEqual(travel.leaveByTime, departure)
    }

    func testLeaveByTimeIsNilWithoutLegs() {
        let travel = Travel(status: .onTime, legs: [], transfers: 0)
        XCTAssertNil(travel.leaveByTime)
        XCTAssertEqual(travel.countdownText, "Unavailable")
    }

    // MARK: - addingWalk

    func testAddingWalkPrependsALegStartingMinutesBeforeDeparture() {
        let departure = Date().addingTimeInterval(10 * 60)
        let travel = Travel(status: .onTime, legs: [makeLeg(planned: departure)], transfers: 0)

        let withWalk = travel.addingWalk(minutesBeforeDeparture: 10)

        XCTAssertEqual(withWalk.legs.count, 2)
        XCTAssertTrue(withWalk.legs[0].isWalking)
        XCTAssertEqual(withWalk.legs[0].destination.name, "A")
        XCTAssertEqual(withWalk.leaveByTime, departure.addingTimeInterval(-10 * 60))
    }

    func testAddingWalkWithZeroMinutesLeavesTravelUnchanged() {
        let departure = Date().addingTimeInterval(10 * 60)
        let travel = Travel(status: .onTime, legs: [makeLeg(planned: departure)], transfers: 0)

        let withWalk = travel.addingWalk(minutesBeforeDeparture: 0)

        XCTAssertEqual(withWalk.legs.count, 1)
        XCTAssertEqual(withWalk.leaveByTime, departure)
    }

    func testOriginAndDestinationSkipTheWalkingLeg() {
        let departure = Date().addingTimeInterval(10 * 60)
        let travel = Travel(
            status: .onTime,
            legs: [makeLeg(originName: "Rotterdam Centraal", destinationName: "Schiphol Airport", planned: departure)],
            transfers: 0
        ).addingWalk(minutesBeforeDeparture: 10)

        XCTAssertEqual(travel.origin?.name, "Rotterdam Centraal")
        XCTAssertEqual(travel.destination?.name, "Schiphol Airport")
    }

    // MARK: - NS mapping

    func testMapsCancelledTripStatus() throws {
        let trip = try Fixtures.trip(legs: [Fixtures.legJSON(origin: Fixtures.stopJSON(), destination: Fixtures.stopJSON())], status: "CANCELLED")
        XCTAssertEqual(Travel(nsTrip: trip).status, .cancelled)
    }

    func testMapsDisruptionTripStatus() throws {
        let trip = try Fixtures.trip(legs: [Fixtures.legJSON(origin: Fixtures.stopJSON(), destination: Fixtures.stopJSON())], status: "DISRUPTION")
        XCTAssertEqual(Travel(nsTrip: trip).status, .disrupted)
    }

    func testMapsNormalTripStatusToOnTime() throws {
        let trip = try Fixtures.trip(legs: [Fixtures.legJSON(origin: Fixtures.stopJSON(), destination: Fixtures.stopJSON())], status: "NORMAL")
        XCTAssertEqual(Travel(nsTrip: trip).status, .onTime)
    }

    func testMapsTransfersAndUsesFirstAndLastLegForOriginDestination() throws {
        let firstLeg = Fixtures.legJSON(origin: Fixtures.stopJSON(name: "Rotterdam Centraal"), destination: Fixtures.stopJSON(name: "Den Haag HS"))
        let secondLeg = Fixtures.legJSON(origin: Fixtures.stopJSON(name: "Den Haag HS"), destination: Fixtures.stopJSON(name: "Schiphol Airport"))
        let trip = try Fixtures.trip(legs: [firstLeg, secondLeg], transfers: 1)

        let travel = Travel(nsTrip: trip)

        XCTAssertEqual(travel.transfers, 1)
        XCTAssertEqual(travel.origin?.name, "Rotterdam Centraal")
        XCTAssertEqual(travel.destination?.name, "Schiphol Airport")
    }

    // MARK: - Reachability

    // Regression test for the reported bug: with a 10-minute walking time applied,
    // a travel departing in 5 minutes is no longer reachable and the next one
    // should be picked as "reachable" instead.
    func testReachableIndexExcludesATravelThatCanNoLongerBeReached() {
        let now = Date()
        let soon = Travel(status: .onTime, legs: [makeLeg(planned: now.addingTimeInterval(5 * 60))], transfers: 0)
            .addingWalk(minutesBeforeDeparture: 10)
        let later = Travel(status: .onTime, legs: [makeLeg(planned: now.addingTimeInterval(20 * 60))], transfers: 0)

        XCTAssertEqual([soon, later].reachableIndex(asOf: now), 1)
    }

    func testReachableIndexPicksTheFirstReachableTravel() {
        let now = Date()
        let soon = Travel(status: .onTime, legs: [makeLeg(planned: now.addingTimeInterval(5 * 60))], transfers: 0)
        let later = Travel(status: .onTime, legs: [makeLeg(planned: now.addingTimeInterval(20 * 60))], transfers: 0)

        XCTAssertEqual([soon, later].reachableIndex(asOf: now), 0)
    }

    func testReachableIndexIsNilWhenNoneAreReachable() {
        let now = Date()
        let soon = Travel(status: .onTime, legs: [makeLeg(planned: now.addingTimeInterval(5 * 60))], transfers: 0)
            .addingWalk(minutesBeforeDeparture: 10)

        XCTAssertNil([soon].reachableIndex(asOf: now))
    }

    func testReachableIndexOnEmptyTravelsIsNil() {
        XCTAssertNil([Travel]().reachableIndex())
    }
}
