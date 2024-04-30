//
//  ActivityDeckView.swift
//  ImBored
//
//  Created by Jordan Carter on 4/24/24.
//

import SwiftUI
import SwiftData


struct ActivityCardContent: View {
    
    init(
        item: Activity,
        isShuffling: Bool = false,
        inSheet: Bool = false
    ) {
        self.item = item
        self.isShuffling = isShuffling
        self.inSheet = inSheet
    }
    
    private let item: Activity
    private let isShuffling: Bool
    private let inSheet: Bool
    
    @EnvironmentObject private var saveManager: SaveManager
    
    
    private let numberSize = 50.0
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 5)
                .stroke(.blue, lineWidth: 1)
                .padding(numberSize/2)
                .overlay(cardContent.padding(numberSize))
            Circle()
                .fill(.clear)
                .frame(width: 70, height: numberSize)
                .overlay(numberView)
        }
        .multilineTextAlignment(.center)
        .fontDesign(.serif)
        .background(Color.white)
        .cornerRadius(10)
        .environment(\.sizeCategory, .medium)
        .overlay {
            
        }
        .rotation3DEffect(
            isShuffling ? .degrees(180) : .zero, axis: (x: 0, y: 1, z: 0)
        )
    }
}

private extension ActivityCardContent {
    
    var cardContent: some View {
        VStack(spacing: 30) {
            title
            text
            Spacer()
            Divider()
            footnote
        }
        .opacity(isShuffling ? 0.5 : 1)
    }
    
    
    var numberView: some View {
        Button("Save") {
            print("Save button tapped" + item.activity)
            saveManager.addActivity(item)
        }
        .fontWeight(.bold)
        .padding()
        .background(Circle().fill(.white))
        .foregroundColor(.black)
        
    }
    
    var title: some View {
        Text(item.activity)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.black)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.top)
        
        
    }
    
    var text: some View {
        VStack{
            
            Text("Type: \(item.type)")
                .font(.custom("Avenir Next", size: 30))
                .foregroundColor(.black)
            
            Text(String(format: "Participants: %.0f", item.participants))
                .font(.custom("Avenir Next", size: 30))
                .foregroundColor(.black)
            
            Text(String(format: "Price: $%.02f", item.price))
                .font(.custom("Avenir Next", size: 30))
                .foregroundColor(.black)
            
            HStack{
                Text("Difficulty:")
                    .font(.custom("Avenir Next", size: 30))
                    .foregroundColor(.black)
                DifficultyMeter(value: item.accessibility)
            }
        }
    }
    
    var footnote: some View {
        Text(inSheet ? "Swipe down to close" : "Swipe left or right for new activities")
            .font(.footnote)
            .fixedSize(horizontal: false, vertical: true)
            .foregroundColor(.black)
    }
}


#Preview {
    
    ActivityCardContent(item: Activity())
}
