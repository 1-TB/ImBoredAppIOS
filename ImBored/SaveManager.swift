//
//  SaveManager.swift
//  ImBored
//
//  Created by Jordan Carter on 4/29/24.
//

import Foundation

class SaveManager: ObservableObject {
    @Published var savedActivities: [Activity] = []
    
    func addActivity(_ activity: Activity) {
        savedActivities.append(activity)
    }
    
    func removeActivity(_ activity: Activity) {
        if let index = savedActivities.firstIndex(where: { $0.key == activity.key }) {
            savedActivities.remove(at: index)
        }
    }
}
