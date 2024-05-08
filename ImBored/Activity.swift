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
        activity = "Go to the Store and go shopping."
        type = "Busywork"
        link = ""
        key = ""
        participants = 1
        accessibility = 0.2
        price = 100
    }
    
    //Static needed var/func
    static let activityTypes = ["Any", "education", "recreational", "social", "diy", "charity", "cooking", "relaxation", "music", "busywork"]
    static func getActivities(type: String, count: Int, completion: @escaping (Result<[Activity], Error>) -> Void) {
        var activities = [Activity]()
        let dispatchGroup = DispatchGroup()
        
        for _ in 0..<count {
            dispatchGroup.enter()
            
            let apiURL: URL
            if type == "Any" {
                //apiURL = URL(string: "https://ji2me90qk5.execute-api.us-east-2.amazonaws.com/Test/activity")!
                apiURL = URL(string: "https://www.boredapi.com/api/activity")!
            } else {
                //apiURL = URL(string: "https://ji2me90qk5.execute-api.us-east-2.amazonaws.com/Test/activity/type/\(type)")!
                apiURL = URL(string: "https://www.boredapi.com/api/activity?type=\(type)")!
            }
            
            var request = URLRequest(url: apiURL)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { data, _, error in
                if let error = error {
                    completion(.failure(error))
                    dispatchGroup.leave()
                    return
                }
                
                guard let data = data else {
                    completion(.failure(APIError.emptyInput))
                    dispatchGroup.leave()
                    return
                }
                
                do {
                    let activity = try JSONDecoder().decode(Activity.self, from: data)
                    activities.append(activity)
                    dispatchGroup.leave()
                } catch {
                    completion(.failure(APIError.decodingFailed))
                    dispatchGroup.leave()
                }
            }.resume()
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(.success(activities))
        }
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
