//
//  NSTravelMapper.swift
//  Commuto
//

import Foundation

/// Adapts NS's `Trip` wire model into the provider-agnostic `Travel` domain type.
/// This is the seam a future country strategy would implement to plug its own
/// trip representation into the rest of the app.
extension Travel {
    init(nsTrip trip: Trip) {
        self.init(
            status: NSTravelMapper.status(for: trip.status),
            legs: trip.legs.map(NSTravelMapper.leg),
            transfers: trip.transfers
        )
    }
}

enum NSTravelMapper {
    static func status(for status: TripStatus) -> TravelStatus {
        switch status {
        case .cancelled:
            return .cancelled
        case .disruption, .alternativeTransport, .changeNotPossible, .maintenance, .uncertain:
            return .disrupted
        case .replacement, .additional, .special, .normal:
            return .onTime
        }
    }

    static func stop(for stop: TripOriginDestination) -> TravelStop {
        let formatter = ISO8601DateFormatter()
        return TravelStop(
            name: stop.name ?? "Unknown",
            plannedTime: stop.plannedDateTime.flatMap { formatter.date(from: $0) },
            actualTime: stop.actualDateTime.flatMap { formatter.date(from: $0) },
            plannedTrack: stop.plannedTrack,
            actualTrack: stop.actualTrack
        )
    }

    static func leg(for leg: Leg) -> TravelLeg {
        let product = leg.product
        return TravelLeg(
            origin: stop(for: leg.origin),
            destination: stop(for: leg.destination),
            transportIcon: product.map { icon(for: $0.type) },
            transportLabel: product?.displayName ?? product?.shortCategoryName ?? product?.type.rawValue,
            lineNumber: product?.number,
            direction: leg.direction,
            isCancelled: leg.cancelled,
            isWalking: false
        )
    }

    static func icon(for type: TransportType) -> String {
        switch type {
        case .train: return "tram.fill"
        case .bus: return "bus.fill"
        case .tram: return "tram.fill"
        case .metro: return "metro"
        case .ferry: return "ferry.fill"
        case .walk: return "figure.walk"
        case .bike: return "bicycle"
        case .car: return "car.fill"
        case .taxi: return "car.fill"
        case .sharedModality, .unknown: return "questionmark.circle"
        }
    }
}
