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


#Preview {
    SavedView()
        .environmentObject(SaveManager())
}
