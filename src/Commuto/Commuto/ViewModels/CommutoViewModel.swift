//
//  CommutoViewModel.swift
//  Commuto
//

import SwiftUI
import Combine

class CommutoViewModel: ObservableObject {
    @Published var travel: TravelState
    private var timer: Timer?
    private var httpClient: NSHttpClient
    @Published var isLoading = false
    @AppStorage("departureStation") private var departureStation = ""
    @AppStorage("arrivalStation") private var arrivalStation = ""
    
    init() {
        travel = .init()
        httpClient = .init()
        
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
        
        let response = await httpClient.getTrips(from: departureStation, to: arrivalStation)
        
        let now = Date()
        let formatter = ISO8601DateFormatter()
        let nextTrip = response?.trips.first { trip in
            guard let firstLeg = trip.legs.first,
                  let actualDateTimeString = firstLeg.origin.actualDateTime,
                  let departureDate = formatter.date(from: actualDateTimeString) else {
                return false
            }
            return departureDate > now
        }

        travel = travel.update(trip: nextTrip)
        await MainActor.run { isLoading = false }
    }
}

class TravelState {
    public var status: String
    public var nextDepartureTime: String?
    public var numberOfTransfers: Int?
    public var trip: Trip?
    
    init() {
        self.status = "Initial"
    }
    
    func getDisplayText() -> String {
        if (self.status == "Loading") {
            return "Loading..."
        }
        
        if (self.nextDepartureTime != nil) {
            return convertDateAsHumanReadable(dateString: nextDepartureTime!)
        }
        
        return "Error"
    }
    
    func convertDateAsHumanReadable(dateString: String) -> String
    {
        let formatter = ISO8601DateFormatter()
        let date = formatter.date(from: dateString)!

        let relativeDateFormatter = RelativeDateTimeFormatter()
        relativeDateFormatter.unitsStyle = .full
        return relativeDateFormatter.localizedString(for: date, relativeTo: Date())
    }
    
    internal func update(trip: Trip?) -> TravelState {
        guard let trip = trip else {
            self.status = "Error"
            return self
        }
        
        self.nextDepartureTime = trip.legs[0].origin.actualDateTime
        self.numberOfTransfers = trip.legs.count
        self.trip = trip
        
        return self
    }
}
