//
//  ContentView.swift
//  GoalSavingApp
//
//  Created by Dianna Museve on 16/02/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var isSetGoat  = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        GeometryReader{ geo in
            NavigationView {
                ScrollView(.vertical){
                    VStack{
                        VStack{
                    HStack(spacing: 10){
                        Image(systemName: "person")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50,height: 50)
                        VStack{
                            Text("Hello There!")
                            Text("It is a Good Day")
                        }
                        Spacer()
                            
                    }
                    
                }
                .background(Color.green.opacity(0.5))
                .frame(height: 100)
                .padding(.top,0)
                VStack{
                    Text("Start Saving your Towards Your Goals")
                    VStack{
                        VStack{
                            Text("Goal Saving")
                            Text("Tern your goal into saving")
                        }
                        
                    }
                    .frame(height: 200)
                    .background(Color.green.opacity(0.5))
                    .onTapGesture{
                        isSetGoat  = true
                    }
                }
                        //MARK::Add Carousel
                        VStack(alignment: .leading, spacing: 10) {
                                    
                
                    
            }
            
            .fullScreenCover(isPresented:$isSetGoat){
                navigate()
            }
                    
                    
            }
            }
            
        }
    }
    @ViewBuilder
    func  navigate() -> some View {
        CreateSavinggoalView()
    }
    private var headerSection: some View {
            HStack(spacing: 15) {
                Circle()
                    .fill(Color.white.opacity(0.2))
                    .frame(width: 50, height: 50)
                    .overlay(Image(systemName: "person").foregroundColor(.white))
                
                VStack(alignment: .leading) {
                    Text("Hello There!").font(.headline)
                    Text("It's a good day to save").font(.subheadline).opacity(0.8)
                }
                .foregroundColor(.white)
                Spacer()
            }
            .padding()
            .background(Color("#063B27"))
        }
    private var goalSavingsHeroCard: some View {
            Button(action: { isSetGoal = true }) {
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Goal Savings").font(.title3).bold()
                        Text("Turn your goals into\nsavings!").font(.subheadline)
                    }
                    Spacer()
                   
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 80, height: 80)
                        .overlay(
                            Image(systemName: "shield.fill")
                                .font(.largeTitle)
                        )
                }
                .padding(30)
                .foregroundColor(.white)
                .background(Color(hex: "#82C952"))
                .cornerRadius(15)
                .padding(.horizontal)
            }
        }
    
}

//#Preview {
//    ContentView()
//}
struct InfoBanner: View {
    var title: String
    var subtitle: String
    var blockColor: Color
    var bgColor: Color
    
    var body: some View {
        HStack(spacing: 0) {
           
            Rectangle()
                .fill(blockColor)
                .frame(width: 80)
            
            // Right Side: Content
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(Color(hex: "#82C952"))
                
                Text(subtitle)
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                    .lineLimit(3)
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(bgColor)
        }
        .cornerRadius(12)
        .clipped()
    }
}
