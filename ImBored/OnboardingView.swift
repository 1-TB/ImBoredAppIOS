//
//  OnboardingView.swift
//  ImBored
//
//  Created by Jordan Carter on 5/1/24.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var showOnboarding: Bool
    
    var body: some View {
        ZStack{
            Color.background.ignoresSafeArea()
            TabView {
                OnboardingStep(
                    title: "Welcome to ImBored!",
                    description: "Discover exciting activities to do when you're bored.",
                    imageName: "onboarding1",
                    showDismissButton: false,
                    showOnboarding: $showOnboarding
                )
                
                OnboardingStep(
                    title: "Swipe Through Activities",
                    description: "Swipe left or right to explore various activities.",
                    imageName: "onboarding2",
                    showDismissButton: false,
                    showOnboarding: $showOnboarding
                )
                
                OnboardingStep(
                    title: "Save Favorite Activities",
                    description: "Tap the heart button to save your favorite activities.",
                    imageName: "onboarding3",
                    showDismissButton: true,
                    showOnboarding: $showOnboarding
                )
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
    }
}

struct OnboardingStep: View {
    let title: String
    let description: String
    let imageName: String
    let showDismissButton: Bool
    @Binding var showOnboarding: Bool
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .padding()
            
            Text(title)
                .font(.custom("Avenir Next", size: 28))
                .fontWeight(.bold)
                .foregroundColor(.foreground)
                .padding()
            
            Text(description)
                .font(.custom("Avenir Next", size: 18))
                .multilineTextAlignment(.center)
                .foregroundColor(.foreground)
                .padding()
            
            if showDismissButton {
                Button(action: {
                    showOnboarding = false
                }) {
                    Text("Get Started")
                        .font(.custom("Avenir Next", size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(red: 0, green: 0.6, blue: 0.86))
                        .cornerRadius(10)
                }
            }
        }
    }
}
