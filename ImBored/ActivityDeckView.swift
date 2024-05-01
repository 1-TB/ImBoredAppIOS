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
    @State private var saved: Bool = false
    @EnvironmentObject private var saveManager: SaveManager
    
    var body: some View {
        VStack(spacing: 30) {
            //Title
            Text("")
            Text(item.activity)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top)
            //Details
            VStack {
                Text("Type: \(item.type)")
                Text("Participants: \(String(format: "%.0f", item.participants))")
                Text("Price: $\(String(format: "%.02f", item.price))")
                HStack {
                    // How easy the activity is
                    Text("Difficulty:")
                    DifficultyMeter(value: item.accessibility)
                }
            }
            .font(.custom("Avenir Next", size: 30))
            .foregroundColor(.black)
            
            Spacer()
            
            Divider()
            //instructions
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
            Button(action: {
                print("Save button tapped " + item.activity)
                if(saved){
                    //remove the save
                    saveManager.savedActivities.removeAll(where: { $0.id == item.id })
                }else{
                    saveManager.addActivity(item)
                   
                }
                saved.toggle()
            }) {
                if saved {
                    // heart filled in red
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                        .font(.system(size: 20))
                        .padding(10)
                        .background(Color(red: 0, green: 0.6, blue: 0.86))
                        .cornerRadius(10)
                       
                } else {
                    Image(systemName: "heart")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .padding(10)
                        .background(Color(red: 0, green: 0.6, blue: 0.86))
                        .cornerRadius(10)
                }
            }
            .fontWeight(.bold)
            .padding()
            .background(Circle().fill(.white))
            .foregroundColor(.black)
            .padding(.bottom)
        }
        .onAppear(){
            //if already saved then set saved to true so we get a red fill
            saved = saveManager.savedActivities.contains(where: { $0.id == item.id })
        }
        .rotation3DEffect(
            //for the shuffle effect
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
        .environmentObject(SaveManager())
}
