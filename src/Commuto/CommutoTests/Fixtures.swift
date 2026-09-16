//
//  Fixtures.swift
//  CommutoTests
//

import Foundation
@testable import Commuto

/// `Trip`/`Leg`/`TripOriginDestination` only expose a `Decodable` initializer
/// (synthesized alongside `Codable`, which suppresses the implicit memberwise
/// initializer), so fixtures are built as JSON and decoded the same way the
/// real NS response is.
enum Fixtures {
    static func stopJSON(name: String = "Station", planned: String? = nil, actual: String? = nil, plannedTrack: String? = nil, actualTrack: String? = nil) -> [String: Any] {
        var json: [String: Any] = ["name": name]
        if let planned { json["plannedDateTime"] = planned }
        if let actual { json["actualDateTime"] = actual }
        if let plannedTrack { json["plannedTrack"] = plannedTrack }
        if let actualTrack { json["actualTrack"] = actualTrack }
        return json
    }

    static func legJSON(origin: [String: Any], destination: [String: Any], cancelled: Bool = false) -> [String: Any] {
        [
            "origin": origin,
            "destination": destination,
            "stops": [],
            "cancelled": cancelled,
            "partCancelled": false,
            "reachable": true,
            "alternativeTransport": false,
            "isAfterCancelledLeg": false,
            "isOnOrAfterCancelledLeg": false,
            "changePossible": true,
            "preSteps": [],
            "postSteps": []
        ]
    }

    static func tripJSON(legs: [[String: Any]], status: String = "NORMAL", transfers: Int = 0) -> [String: Any] {
        [
            "uid": "1",
            "ctxRecon": "recon",
            "status": status,
            "type": "NS",
            "legs": legs,
            "transfers": transfers,
            "optimal": true,
            "realtime": true
        ]
    }

    static func trip(legs: [[String: Any]], status: String = "NORMAL", transfers: Int = 0) throws -> Trip {
        let data = try JSONSerialization.data(withJSONObject: tripJSON(legs: legs, status: status, transfers: transfers))
        return try JSONDecoder().decode(Trip.self, from: data)
    }

    static func travelAdvice(tripJSONs: [[String: Any]]) throws -> TravelAdvice {
        let json: [String: Any] = ["source": "HARP", "trips": tripJSONs]
        let data = try JSONSerialization.data(withJSONObject: json)
        return try JSONDecoder().decode(TravelAdvice.self, from: data)
    }
}
