//
//  CreateSavinggoalView.swift
//  GoalSavingApp
//
//  Created by Ali Kweyu on 16/02/2026.
//

import SwiftUI
struct CreateSavinggoalView: View {
    @State private var goalName = ""
    @State private var selectedCategory = ""
    @State private var amount = ""
    @State private var targetdate = ""
    @State private var goalCategory:[String] = ["Travelling"]
    @State private var navigateToDashboard = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        GeometryReader{geo in
            NavigationView {
            VStack{
           
            ScrollView(.vertical){
                VStack(alignment: .center){
                    Text("Please let's have the following")
                    
                    VStack{
                        Text("Goal Name")
                        TextField("Goal Name",text: $goalName)
                            .textFieldStyle(.roundedBorder)
                        CustomizeTextField(title: "Goal Category", placeholder: "Please enter goal category", options: goalCategory, selection: $selectedCategory)
                        TextField("Terget amount",text: $amount)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                        CustomTextFieldInputDate(title: "Saving terget Date", placeholder: "Enter Saving terget date", text: $targetdate,   rightIcon: "calender", showDoneButton: true)
                        Spacer()
                        Button(action: {
                            navigateToDashboard = true
                            
                        }, label: {
                            Text("Create a Goal")
                                .foregroundColor(Color.white)
                        })
                        .background(Color("#587a3b"))
                        
                    }
                    
                }
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
            .ignoresSafeArea(.all)
            .frame(width: geo.size.width,height: geo.size.height)
            .fullScreenCover(isPresented: $navigateToDashboard){
                navigate()
            }
            
            
        }
        
    }
    @ViewBuilder
    func  navigate() -> some View {
        DashboardView()
    }
}
    
