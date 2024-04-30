//
//  SavedView.swift
//  ImBored
//
//  Created by Jordan Carter on 4/29/24.
//
import SwiftUI

struct SavedView: View {
    @EnvironmentObject private var saveManager: SaveManager
    @State private var selectedActivity: Activity?
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Saved Activities")
                    .font(.custom("Avenir Next", size: 36))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.foreground)
                    .foregroundColor(.white)
                    .padding(.top, 40)
                
                List {
                    ForEach(saveManager.savedActivities, id: \.key) { activity in
                        Button(action: {
                            selectedActivity = activity
                        }) {
                            Text(activity.activity)
                                .font(.custom("Avenir Next", size: 18))
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color(red: 0.12, green: 0.19, blue: 0.24))
                                .cornerRadius(10)
                        }
                        .listRowBackground(Color.clear)
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .sheet(item: $selectedActivity) { activity in
            ActivityDetailView(activity: activity)
        }
    }
}

struct ActivityDetailView: View {
    let activity: Activity
    
    var body: some View {
        ZStack {
            Color(red: 0.1, green: 0.17, blue: 0.22)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text(activity.activity)
                        .font(.custom("Avenir Next", size: 28))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Type: \(activity.type)")
                        .font(.custom("Avenir Next", size: 20))
                        .foregroundColor(.white)
                    
                    Text("Participants: \(String(format: "%.0f", activity.participants))")
                        .font(.custom("Avenir Next", size: 20))
                        .foregroundColor(.white)
                    
                    Text("Price: $\(String(format: "%.2f", activity.price))")
                        .font(.custom("Avenir Next", size: 20))
                        .foregroundColor(.white)
                    
                    HStack {
                        Text("Difficulty:")
                            .font(.custom("Avenir Next", size: 20))
                            .foregroundColor(.white)
                        
                        DifficultyMeter(value: activity.accessibility)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    SavedView()
        .environmentObject(SaveManager())
}
