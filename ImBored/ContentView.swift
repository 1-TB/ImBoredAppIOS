//
//  ContentView.swift
//  ImBored
//
//  Created by Jordan Carter on 4/22/24.
//

import SwiftUI
import DeckKit
import SwiftData
import Lottie

struct ContentView: View {
    // Variables
    @State private var selectedType = "Any"
    @State private var numActivities = 5
    @State private var showSavedView = false
    @StateObject var animation = DeckShuffleAnimation()
    @StateObject private var activityViewModel = ActivityViewModel()
    @State private var isLoading = false
    @State private var showOnboarding = false
    let loadingUrl = URL(string: "https://lottie.host/02fffee0-268c-4d4f-b758-9ed82725e2bc/vEvDyp5GwG.json")!
    
    
    // Shuffle button
    var shuffleButton: some View {
        Button("Pick Random") {
            animation.shuffle($activityViewModel.activityDeck, times: 5)
           
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
                
                // Selectors under Title
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
                
                // The deck/card View
                if activityViewModel.activities.isEmpty {
                    VStack {
                        Text("No activities found.")
                            .font(.custom("Avenir Next", size: 18))
                            .foregroundColor(.foreground)
                    }
                } else {
                    DeckView(
                        $activityViewModel.activityDeck,
                        config: .init(
                            direction: .down,
                            itemDisplayCount: 5
                        ),
                        shuffleAnimation: animation,
                        itemView: actViewCard
                    )
                    .redacted(reason: isLoading ? .placeholder : [])
                    .overlay(){
                        if(isLoading){
                            LottieView {
                              try await LottieAnimation.loadedFrom(url: loadingUrl )
                            }
                            .playing(loopMode: .loop)
                            .scaleEffect(CGSize(width: 0.4, height: 0.4))
                            
                        }
                    }
                    
                   
                }
                
                // Buttons under the Deck
                HStack {
                    shuffleButton
                    Button("Get Activities") {
                        fetchActivities()
                    }
                    .padding()
                    .background(Color(red: 0, green: 0.6, blue: 0.86))
                    .foregroundColor(.white)
                    .font(.custom("Avenir Next", size: 18))
                    .cornerRadius(10)
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
            .sheet(isPresented: $showOnboarding) {
                OnboardingView(showOnboarding: $showOnboarding)
            }
            .onAppear {
                if !UserDefaults.standard.bool(forKey: "didShowOnboarding") {
                    showOnboarding = true
                    UserDefaults.standard.set(true, forKey: "didShowOnboarding")
                }
                fetchActivities()
            }
        }
    }
    
    private func fetchActivities() {
        isLoading = true
       
        activityViewModel.fetchActivities(type: selectedType, count: numActivities) { success in
            isLoading = false
            if !success {
                // Show error message
            }
        }
    }
}

func actViewCard(for act: ActivityDeck) -> some View {
    ActivityCardContent(item: act.activity)
}

#Preview {
    ContentView()
        .environmentObject(SaveManager())
}
