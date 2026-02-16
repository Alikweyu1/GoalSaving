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
                
                
            }
            .navigationTitle("Create a Goal")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "arrow.left")
                    }
                }
            }
            .ignoresSafeArea(.all)
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
}

//#Preview {
//    ContentView()
//}
