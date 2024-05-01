//
//  ContentView.swift
//  ImBored
//
//  Created by Jordan Carter on 4/22/24.
//

import SwiftUI
import DeckKit
import SwiftData

struct ContentView: View {
    //Variables
    @State private var activities = [Activity]()
    @State private var selectedType = "Any"
    @State private var numActivities = 5
    @State private var deck = [ActivityDeck]()
    @State private var showSavedView = false
    @StateObject
    var animation = DeckShuffleAnimation()
    //shuffle button
    var shuffleButton: some View {
        Button("Pick Random") {
            animation.shuffle($deck, times: 5)
        }
        .padding()
        .background(Color(red: 0, green: 0.6, blue: 0.86))
        .foregroundStyle(Color.foreground)
        .font(.custom("Avenir Next", size: 18))
        .cornerRadius(10)
    }
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("I'm Bored!")
                    .font(.custom("Avenir Next", size: 36))
                    .fontWeight(.bold)
                    .foregroundColor(.foreground)
                    .padding(.top, 40)
            //Selectors under Title
                HStack {
                    Picker("Activity Type", selection: $selectedType) {
                        ForEach(Activity.activityTypes, id: \.self) {
                            Text($0)
                        }
                    }
                    .padding(.horizontal)
                    .background(Color(red: 0.16, green: 0.23, blue: 0.28))
                    .cornerRadius(10)
                    .foregroundColor(.foreground)
                    
                    Stepper("Number of Activities: \(numActivities)", value: $numActivities, in: 1...10)
                        .padding(.horizontal)
                        .foregroundColor(.foreground)
                }
                .padding()
                .background(Color(red: 0.12, green: 0.19, blue: 0.24))
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                //The deck/card View
                DeckView(
                    $deck,
                    config: .init(
                        direction: .down,
                        itemDisplayCount: 5
                    ),
                    
                    shuffleAnimation: animation,
                    itemView: actViewCard
                )
                //Buttons under the Deck
                HStack{
                    Button("Get Activities") {
                        Task {
                            do {
                                activities = try await Activity.getActivities(type: selectedType, count: numActivities)
                                deck = activities.map { ActivityDeck(activity: $0) }
                            } catch {
                                print(error)
                            }
                        }
                    }
                    .padding()
                    .background(Color(red: 0, green: 0.6, blue: 0.86))
                    .foregroundColor(.white)
                    .font(.custom("Avenir Next", size: 18))
                    .cornerRadius(10)
                    shuffleButton
                    Button(action: {
                        showSavedView = true
                    }) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 36))
                            .padding(10)
                            .background(Color(red: 0, green: 0.6, blue: 0.86))
                            .cornerRadius(10)
                    }
                }
                
            }
            .sheet(isPresented: $showSavedView) {
                SavedView()
            }
            //On load, get something to display from the api
            .onAppear(){
                Task {
                    do {
                        activities = try await Activity.getActivities(type: selectedType, count: numActivities)
                        deck = activities.map { ActivityDeck(activity: $0) }
                    } catch {
                        print(error)
                    }
                }
            }
        }
        
    }
}

func actViewCard(for act: ActivityDeck) -> some View {
    ActivityCardContent(
        item: act.activity
    )
}

#Preview {
    ContentView()
        .environmentObject(SaveManager())
    
}
