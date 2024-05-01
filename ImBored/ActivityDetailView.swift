//
//  ActivityDetailView.swift
//  ImBored
//
//  Created by Jordan Carter on 5/1/24.
//

import Foundation
import SwiftUI

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
