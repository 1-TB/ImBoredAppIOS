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
    @State private var showShareSheet = false
    
    var body: some View {
        ZStack {
            Color(.background)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if !activity.link.isEmpty {
                        Link("Learn More", destination: URL(string: activity.link)!)
                            .font(.custom("Avenir Next", size: 20))
                            .foregroundColor(.blue)
                    }
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
                    Button(action: {
                        showShareSheet = true
                    }) {
                        Text("Share")
                            .font(.custom("Avenir Next", size: 20))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(red: 0, green: 0.6, blue: 0.86))
                            .cornerRadius(10)
                    }
                }
            
                .padding()
            }
        }.sheet(isPresented: $showShareSheet) {
            ActivityShareSheet(activity: activity)
        }
    }
}
struct ActivityShareSheet: UIViewControllerRepresentable {
    let activity: Activity
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let activityItems: [Any] = [activity.activity]
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
