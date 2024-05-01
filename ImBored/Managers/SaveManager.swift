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
        save()
    }
    
    func removeActivity(_ activity: Activity) {
        if let index = savedActivities.firstIndex(where: { $0.key == activity.key }) {
            savedActivities.remove(at: index)
            save()
        }
    }
    
    init() {
        load()
    }
    
    func save() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(savedActivities) {
            UserDefaults.standard.set(encodedData, forKey: "savedActivities")
        }
    }
    
    func load() {
        if let savedData = UserDefaults.standard.data(forKey: "savedActivities") {
            let decoder = JSONDecoder()
            if let decodedActivities = try? decoder.decode([Activity].self, from: savedData) {
                savedActivities = decodedActivities
            }
        }
    }
}
