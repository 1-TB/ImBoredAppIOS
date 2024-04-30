//
//  Activity.swift
//  ImBored
//
//  Created by Jordan Carter on 4/22/24.
//

import Foundation
import DeckKit

struct Activity: Codable, Identifiable {
    
    let activity,type,link,key: String
    let participants,price,accessibility: Double
    var id: String {
        return key
    }
    init() {
        activity = "Go to the Store"
        type = "Busywork"
        link = ""
        key = ""
        participants = 1
        accessibility = 0.2
        price = 100
    }
    static let activityTypes = ["Any", "education", "recreational", "social", "diy", "charity", "cooking", "relaxation", "music", "busywork"]
    static func getActivities(type: String, count: Int) async throws -> [Activity] {
        var activities = [Activity]()
        
        for _ in 0..<count {
            let apiURL: URL
            if type == "Any" {
                apiURL = URL(string: "https://www.boredapi.com/api/activity")!
            } else {
                apiURL = URL(string: "https://www.boredapi.com/api/activity?type=\(type)")!
            }
            
            var request = URLRequest(url: apiURL)
            request.httpMethod = "GET"
            
            let (data, _) = try await URLSession.shared.data(for: request)
            
            do {
                let activity = try JSONDecoder().decode(Activity.self, from: data)
                activities.append(activity)
            } catch {
                throw APIError.decodingFailed
            }
        }
        
        return activities
    }
    
    enum APIError: Error {
        case emptyInput
        case invalidURL
        case decodingFailed
    }
    
    
}
struct ActivityDeck: DeckItem{
    static func == (lhs: ActivityDeck, rhs: ActivityDeck) -> Bool {
        return lhs.id == rhs.id
        
    }
    var id = UUID()
    var activity: Activity
    init(activity: Activity){
        self.activity = activity
    }
}
