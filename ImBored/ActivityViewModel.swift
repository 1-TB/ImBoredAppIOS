//
//  ActivityViewModel.swift
//  ImBored
//
//  Created by Jordan Carter on 5/1/24.
//

import Foundation
import CoreData

class ActivityViewModel: ObservableObject {
    @Published var activities: [Activity] = []
    @Published var activityDeck: [ActivityDeck] = []
    
    func fetchActivities(type: String, count: Int, completion: @escaping (Bool) -> Void) {
        Activity.getActivities(type: type, count: count) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let activities):
                    self?.activities = activities
                    self?.activityDeck = activities.map { ActivityDeck(activity: $0) }
                    completion(true)
                case .failure(let error):
                    print("Error fetching activities: \(error.localizedDescription)")
                    completion(false)
                }
            }
        }
    }
}
