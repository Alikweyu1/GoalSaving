//
//  ContentView.swift
//  GoalSavingApp
//
//  Created by Ali Kweyu on 16/02/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var isSetGoal  = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        GeometryReader{ geo in
            NavigationView {
                ScrollView(.vertical){
                    VStack{
                        VStack{
                            headerSection
                    
                }
                .background(Color.green.opacity(0.5))
                .frame(height: 100)
                .padding(.top,0)
                VStack{
                    Text("Start Saving your Towards Your Goals")
                    goalSavingsHeroCard()
                    .onTapGesture{
                        isSetGoal  = true
                    }
                }
                        //MARK::Add Carousel
                        VStack(alignment: .leading, spacing: 10) {
                            TabView {
                                InfoBanner(title: "Learn about Savings", subtitle: "Discover the world with our new savings, one step towards your goal", blockColor: Color("#2E5B1A"), bgColor: Color( "#0B2B36")
                                )
                                .padding(.horizontal)
                                InfoBanner(title: "What is Goal?", subtitle: "Answers to your most asked questions", blockColor: Color("#82C952"), bgColor: Color( "#063B27")
                                )
                                .padding(.horizontal)
                                
                            }
                            .frame(height: 160)
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                
                        }
            }
            
            .fullScreenCover(isPresented:$isSetGoal){
                navigate()
            }
                    
                    
            }
            }
            
        }
    }
    @ViewBuilder
    func  navigate() -> some View {
        DashboardView()
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
    @ViewBuilder
     func goalSavingsHeroCard() ->  some View {
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
                .background(Color("#82C952"))
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
                    .foregroundColor(Color("#82C952"))
                
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
