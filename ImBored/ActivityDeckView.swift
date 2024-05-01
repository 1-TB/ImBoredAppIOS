//
//  ActivityDeckView.swift
//  ImBored
//
//  Created by Jordan Carter on 4/24/24.
//

import SwiftUI
import SwiftData

struct ActivityCardContent: View {
    private let item: Activity
    private let isShuffling: Bool
    private let inSheet: Bool
    @EnvironmentObject private var saveManager: SaveManager
    
    var body: some View {
        VStack(spacing: 30) {
            
            Text(item.activity)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top)
                .padding(.top)
            
            VStack {
                Text("Type: \(item.type)")
                Text("Participants: \(String(format: "%.0f", item.participants))")
                Text("Price: $\(String(format: "%.02f", item.price))")
                HStack {
                    Text("Difficulty:")
                    DifficultyMeter(value: item.accessibility)
                }
            }
            .font(.custom("Avenir Next", size: 30))
            .foregroundColor(.black)
            
            Spacer()
            
            Divider()
            
            Text("Swipe left or right for new activities")
                .font(.footnote)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(.black)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(.blue, lineWidth: 1)
        )
        .overlay(alignment: .topLeading) {
            Button("Save") {
                print("Save button tapped " + item.activity)
                saveManager.addActivity(item)
            }
            .fontWeight(.bold)
            .padding()
            .background(Circle().fill(.white))
            .foregroundColor(.black)
            .padding(.bottom)
        }
        .rotation3DEffect(
            isShuffling ? .degrees(180) : .zero, axis: (x: 0, y: 1, z: 0)
        )
        .opacity(isShuffling ? 0.5 : 1)
        .padding()
    }
    
    init(item: Activity, isShuffling: Bool = false, inSheet: Bool = false) {
        self.item = item
        self.isShuffling = isShuffling
        self.inSheet = inSheet
    }
}

//The bars that are filled from none to 5
struct DifficultyMeter: View {
    let value: Double
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<5) { index in
                Circle()
                    .fill(index < Int(value * 5) ? Color(red: 0, green: 0.6, blue: 0.86) : Color.gray)
                    .frame(width: 12, height: 12)
            }
        }
    }
}

#Preview {
    
    ActivityCardContent(item: Activity())
}
