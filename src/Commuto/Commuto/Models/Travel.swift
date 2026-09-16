//
//  Travel.swift
//  Commuto
//

import Foundation

/// Provider-agnostic view of a single journey. Built by a provider-specific
/// mapper (e.g. `NSTravelMapper`) from that provider's own trip representation,
/// then optionally combined with the user's configured walking time via
/// `addingWalk(minutesBeforeDeparture:)`.
struct Travel {
    let status: TravelStatus
    let legs: [TravelLeg]
    let transfers: Int

    private var journeyLegs: [TravelLeg] { legs.filter { !$0.isWalking } }

    var origin: TravelStop? { journeyLegs.first?.origin }
    var destination: TravelStop? { journeyLegs.last?.destination }

    /// The time by which the user needs to leave: the first leg's departure,
    /// which is the walking leg's start time when one has been added.
    var leaveByTime: Date? { legs.first?.origin.displayTime }

    var countdownText: String {
        guard let leaveByTime else { return "Unavailable" }
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: leaveByTime, relativeTo: Date())
    }

    /// Prepends a walking leg that ends at the first leg's origin, starting
    /// `minutes` earlier. A non-positive `minutes` leaves the travel unchanged.
    func addingWalk(minutesBeforeDeparture minutes: Int) -> Travel {
        guard minutes > 0, let firstOrigin = legs.first?.origin, let departure = firstOrigin.displayTime else {
            return self
        }

        let walkLeg = TravelLeg(
            origin: TravelStop(
                name: "Start",
                plannedTime: departure.addingTimeInterval(-Double(minutes) * 60),
                actualTime: departure.addingTimeInterval(-Double(minutes) * 60),
                plannedTrack: nil,
                actualTrack: nil
            ),
            destination: TravelStop(
                name: "Destination",
                plannedTime: firstOrigin.plannedTime,
                actualTime: firstOrigin.plannedTime,
                plannedTrack: nil,
                actualTrack: nil
            ),
            transportIcon: "figure.walk",
            transportLabel: "Walk",
            lineNumber: nil,
            direction: nil,
            isCancelled: false,
            isWalking: true
        )

        return Travel(status: status, legs: [walkLeg] + legs, transfers: transfers)
    }
}

extension Array where Element == Travel {
    /// The index of the next travel the user can still reach, given each
    /// travel's own `leaveByTime`. `nil` when none are reachable.
    func reachableIndex(asOf now: Date = Date()) -> Int? {
        firstIndex { travel in
            guard let leaveByTime = travel.leaveByTime else { return true }
            return leaveByTime > now
        }
    }
}
