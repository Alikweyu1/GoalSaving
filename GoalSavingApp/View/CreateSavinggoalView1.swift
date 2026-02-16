//
//  CreateSavinggoalView.swift
//  GoalSavingApp
//
//  Created by Ali Kweyu on 16/02/2026.
//

import SwiftUI
struct CreateSavinggoalView1: View {
    @State private var goalName = ""
    @State private var selectedCategory = ""
    @State private var amount = ""
    @State private var targetdate = ""
    @State private var goalCategory:[String] = ["Travelling"]
    @State private var navigateToDashboard = false
    @State private var showSuccessAlert = false
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
                            showSuccessAlert = true
//                            navigateToDashboard = true
                            
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
            .padding(.horizontal)
            .navigationTitle("Create a Goal")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.primary)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.primary)
                    }
                }
            }
        }
        
        // Reusable Success Alert Overlay
        if showSuccessAlert {
            SuccessAlertView(
                title: "\(goalName) Goal",
                message: "You are one step closer to reaching your target",
                buttonText: "Go to My Goals"
            ) {
                // Logic from your saved instructions:
                // completion(payload.message, true, payload)
                showSuccessAlert = false
                dismiss() {
                navigateToDashboard = true
                }
            }
        }
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
    
