//
//  ImBoredApp.swift
//  ImBored
//
//  Created by Jordan Carter on 4/22/24.
//

import SwiftUI
import SwiftData

@main
struct ImBoredApp: App {
    @StateObject private var saveManager = SaveManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(saveManager)
        }
        
    }
}
