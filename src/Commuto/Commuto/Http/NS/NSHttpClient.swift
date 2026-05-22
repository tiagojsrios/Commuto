//
//  NSHttpClient.swift
//  Commuto
//

import Foundation
import SwiftUI

class NSHttpClient {
    @AppStorage("apiKey") private var apiKey = ""
    private var urlComponents = URLComponents(string: "https://gateway.apiportal.ns.nl/reisinformatie-api/api/v3/trips")
    
    init() {
    }
    
    func getTrips(from: String, to: String) async -> TravelAdvice? {
        if (apiKey.isEmpty) {
            return nil;
        }
        
        self.urlComponents!.queryItems = [
            URLQueryItem(name: "lang", value: "en"),
            URLQueryItem(name: "fromStation", value: from),
            URLQueryItem(name: "toStation", value: to),
            URLQueryItem(name: "originWalk", value: "false"),
            URLQueryItem(name: "originBike", value: "false"),
            URLQueryItem(name: "originCar", value: "false"),
            URLQueryItem(name: "destinationWalk", value: "false"),
            URLQueryItem(name: "destinationBike", value: "false"),
            URLQueryItem(name: "destinationCar", value: "false"),
            URLQueryItem(name: "shorterChange", value: "false"),
            URLQueryItem(name: "travelAssistance", value: "false"),
            URLQueryItem(name: "searchForAccessibleTrip", value: "false"),
            URLQueryItem(name: "localTrainsOnly", value: "false"),
            URLQueryItem(name: "excludeHighSpeedTrains", value: "false"),
            URLQueryItem(name: "excludeTrainsWithReservationRequired", value: "false"),
            URLQueryItem(name: "discount", value: "NO_DISCOUNT"),
            URLQueryItem(name: "travelClass", value: "2"),
            URLQueryItem(name: "passing", value: "false"),
            URLQueryItem(name: "travelRequestType", value: "DEFAULT")
        ]
        
        var request = URLRequest(url: self.urlComponents!.url!)
        
        request.setValue(self.apiKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                return try JSONDecoder().decode(TravelAdvice.self, from: data)
            }
        } catch {
        }
        
        return nil;
    }
}
